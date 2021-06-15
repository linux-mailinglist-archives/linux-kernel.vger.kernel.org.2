Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2C3A7D88
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhFOLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:51:15 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:65032 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhFOLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:51:14 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 07:51:14 EDT
Received: from [0.0.0.0] (unknown [116.24.56.76])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 2419AE00AB;
        Tue, 15 Jun 2021 19:41:39 +0800 (CST)
Subject: Re: [PATCH v1 1/6] mm/hwpoison: mf_mutex for soft offline and
 unpoison
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
 <20210614021212.223326-2-nao.horiguchi@gmail.com>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <b827a97a-661a-be04-f154-49be6087aa57@sangfor.com.cn>
Date:   Tue, 15 Jun 2021 19:41:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614021212.223326-2-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh0YT1YYThgeTEJMTEMZT0NVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46ASo4SD8VFUhKSQwJDxo9
        GkwaCxxVSlVKTUlITE5MSEtLSkxIVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSk1VSU9VTk1VTE1ZV1kIAVlBSU9CQzcG
X-HM-Tid: 0a7a0f7a20632c17kusn2419ae00ab
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/14 10:12, Naoya Horiguchi wrote:

>   
> @@ -2171,6 +2177,8 @@ int soft_offline_page(unsigned long pfn, int flags)
>   		return -EIO;
>   	}
>   
> +	mutex_lock(&mf_mutex);
> +
>   	if (PageHWPoison(page)) {
>   		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
>   		put_ref_page(ref_page);

Did you miss mutex_unlock() here when page already poisoned ?

> @@ -2194,5 +2202,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>   			 __func__, pfn, page->flags, &page->flags);
>   	}
>   
> +	mutex_unlock(&mf_mutex);
> +
>   	return ret;
>   }
> 

--
Thanks,
- Ding Hui
