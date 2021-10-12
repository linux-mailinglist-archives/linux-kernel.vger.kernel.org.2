Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29723429C12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhJLDuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:50:35 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:33866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232185AbhJLDue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:50:34 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1D3D21802DA54;
        Tue, 12 Oct 2021 03:48:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id C3ACA240234;
        Tue, 12 Oct 2021 03:48:28 +0000 (UTC)
Message-ID: <bcf19290a2ed959fdf8d80a3668a19e79c87ca7f.camel@perches.com>
Subject: Re: [PATCH virt-pci] Fix application of sizeof to pointer
From:   Joe Perches <joe@perches.com>
To:     davidcomponentone@gmail.com, jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Date:   Mon, 11 Oct 2021 20:48:27 -0700
In-Reply-To: <20211012032333.184581-1-davidcomponentone@gmail.com>
References: <20211012032333.184581-1-davidcomponentone@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.17
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C3ACA240234
X-Stat-Signature: binj6x89q49obhw13edru8en7ewo6tc8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18JxvwUdVn1sTGW1bpFG5dyWY/YH1ba9Eo=
X-HE-Tag: 1634010508-615943
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-12 at 11:23 +0800, davidcomponentone@gmail.com wrote:
> From: David Yang <davidcomponentone@gmail.com>
> 
> The coccinelle check report:
> "./arch/um/drivers/virt-pci.c:192:20-26:
> ERROR: application of sizeof to pointer"
> Using the "sizeof(buf->data)" to fix it.
[]
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
[]
> @@ -189,7 +189,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
>  	buf = get_cpu_var(um_pci_msg_bufs);
>  	data = buf->data;
> 
> -	memset(data, 0xff, sizeof(data));
> +	memset(data, 0xff, sizeof(buf->data));

Perhaps change this to:

	memset(buf->data, 0xff, sizeof(buf->data));
	data = buf->data;

but honestly, the indirection to data doesn't make the code
much more readable so maybe just remove data altogether.
---
 arch/um/drivers/virt-pci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c080666330234..75e05ead97b9a 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -180,7 +180,6 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	};
 	/* buf->data is maximum size - we may only use parts of it */
 	struct um_pci_message_buffer *buf;
-	u8 *data;
 	unsigned long ret = ~0ULL;
 
 	if (!dev)
@@ -189,7 +188,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	buf = get_cpu_var(um_pci_msg_bufs);
 	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(buf->data, 0xff, sizeof(buf->data));
 
 	switch (size) {
 	case 1:
@@ -204,22 +203,22 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		goto out;
 	}
 
-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
+	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buf->data, 8))
 		goto out;
 
 	switch (size) {
 	case 1:
-		ret = data[0];
+		ret = buf->data[0];
 		break;
 	case 2:
-		ret = le16_to_cpup((void *)data);
+		ret = le16_to_cpup((void *)buf->data);
 		break;
 	case 4:
-		ret = le32_to_cpup((void *)data);
+		ret = le32_to_cpup((void *)buf->data);
 		break;
 #ifdef CONFIG_64BIT
 	case 8:
-		ret = le64_to_cpup((void *)data);
+		ret = le64_to_cpup((void *)buf->data);
 		break;
 #endif
 	default:


