Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B23E0C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 04:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhHECGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 22:06:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13232 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhHECF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 22:05:59 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GgBlh5LlXz1CRrR;
        Thu,  5 Aug 2021 10:05:36 +0800 (CST)
Received: from [10.174.176.245] (10.174.176.245) by
 dggeme766-chm.china.huawei.com (10.3.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:05:42 +0800
Subject: Re: [PATCH] VMCI: fix NULL pointer dereference when unmapping queue
 pair
From:   "wanghai (M)" <wanghai38@huawei.com>
To:     <jhansen@vmware.com>, <vdasa@vmware.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <dtor@vmware.com>,
        <georgezhang@vmware.com>, <acking@vmware.com>
CC:     <pv-drivers@vmware.com>, <linux-kernel@vger.kernel.org>
References: <20210804134853.3175473-1-wanghai38@huawei.com>
Message-ID: <4e66f922-c081-0b00-d77e-fb1e1d5e9d49@huawei.com>
Date:   Thu, 5 Aug 2021 10:05:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210804134853.3175473-1-wanghai38@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme766-chm.china.huawei.com (10.3.19.112)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/8/4 21:48, Wang Hai Ð´µÀ:
> I got a NULL pointer dereference report when doing fuzz test:
>
> Call Trace:
>    qp_release_pages+0xae/0x130
>    qp_host_unregister_user_memory.isra.25+0x2d/0x80
>    vmci_qp_broker_unmap+0x191/0x320
>    ? vmci_host_do_alloc_queuepair.isra.9+0x1c0/0x1c0
>    vmci_host_unlocked_ioctl+0x59f/0xd50
>    ? do_vfs_ioctl+0x14b/0xa10
>    ? tomoyo_file_ioctl+0x28/0x30
>    ? vmci_host_do_alloc_queuepair.isra.9+0x1c0/0x1c0
>    __x64_sys_ioctl+0xea/0x120
>    do_syscall_64+0x34/0xb0
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> When a queue pair is created by the following call, it will not
> register the user memory if the page_store is NULL, and the
> entry->state will be set to VMCIQPB_CREATED_NO_MEM.
>
> vmci_host_unlocked_ioctl
>    vmci_host_do_alloc_queuepair
>      vmci_qp_broker_alloc
>        qp_broker_alloc
>          qp_broker_create // set entry->state = VMCIQPB_CREATED_NO_MEM;
>
> When unmapping this queue pair, qp_host_unregister_user_memory() will
> be called to unregister the non-existent user memory, which will
> result in a null pointer reference. It will also change
> VMCIQPB_CREATED_NO_MEM to VMCIQPB_CREATED_MEM, which should not be
> present in this operation.
>
> If the qp broker has mem, there no need to register or unregister
> the user memory when mapping or unmapping the qp broker.

If the qp broker has mem, there no need to register the user memory when mapping the qp broker.
If the qp broker has no mem, there no need to unregister the user memory when ummapping the qp broker.

> Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>   drivers/misc/vmw_vmci/vmci_queue_pair.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index 880c33ab9f47..0c6fb4c0d5ac 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -2243,7 +2243,8 @@ int vmci_qp_broker_map(struct vmci_handle handle,
>   
>   	result = VMCI_SUCCESS;
>   
> -	if (context_id != VMCI_HOST_CONTEXT_ID) {
> +	if (context_id != VMCI_HOST_CONTEXT_ID &&
> +	    QPBROKERSTATE_HAS_MEM(entry)) {
>   		struct vmci_qp_page_store page_store;
>   

should be:
-	if (context_id != VMCI_HOST_CONTEXT_ID) {
+	if (context_id != VMCI_HOST_CONTEXT_ID &&
+	    !QPBROKERSTATE_HAS_MEM(entry)) {

>   		page_store.pages = guest_mem;
> @@ -2350,7 +2351,8 @@ int vmci_qp_broker_unmap(struct vmci_handle handle,
>   		goto out;
>   	}
>   
> -	if (context_id != VMCI_HOST_CONTEXT_ID) {
> +	if (context_id != VMCI_HOST_CONTEXT_ID &&
> +	    QPBROKERSTATE_HAS_MEM(entry)) {
>   		qp_acquire_queue_mutex(entry->produce_q);
>   		result = qp_save_headers(entry);
>   		if (result < VMCI_SUCCESS)
