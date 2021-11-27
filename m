Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E408345F7CF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 02:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbhK0BNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 20:13:48 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16641 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbhK0BLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 20:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637975313; x=1669511313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JeEh0wBirBhWicGL8pepRh1yqbBvRlV2EWUTRaq+jHY=;
  b=VEhqQc1tuZxXZxeGNrggg/gU7Dcigi1QhPeBEk+BcsCLN9eBSNJqT4q9
   cGv+i7JtIHUI38ArKVXG0bl+WL91oWrDYiFaMQm+C4nRddwTymMrVn6hl
   YoC8T5pHAJ8f3OGYLN5yeHZc+ePKAXm3IP+D0OTMbVzwOqTIx6qn6x0VY
   yBPvZ2G7vJCg4uzlYB1bRLdxDeLym0VogpfLaJUzIUwyi1RSIELSfSNcr
   MLVVDgXs5w7H7x5ZrYXzCF3peJK/ZLfMnG9kFzgfY3nt7QvixzdyEXp/G
   kHQiAnRPLwjwW940elfH5EmSM2RqKy6cT+vlCgewQUh4PudIWGjNrAlZc
   w==;
X-IronPort-AV: E=Sophos;i="5.87,267,1631548800"; 
   d="scan'208";a="187798508"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2021 09:08:33 +0800
IronPort-SDR: WalicxANJ1g838oWa7ciEQQ+C7kLw7l9OU1viC7o5EqQPc1xPPOgnrB3NZsXqRHmXZGtBf4tWN
 ULDWa597osBw8H2aZcXCFXi4mSYta5o05ljogj7JY/Xj0Si50vqXMj9mZwYKF85Ol54n6KQSAq
 wIidEmExJhDUG0FdoLSZGy94lW6ykWeEbCLHfyDBT+e+C5GQ3r2tRIgMxREgW3vhpRxpHphN8S
 gfgbWix/7sq7Acigs2ysTpQzDYxqP2Eu2H8syeyML0A0R9kef9bLL0qeyNk+UgKCvotDKvNgN2
 9NsUzNBfVGvBpinieToY9kpk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 16:43:22 -0800
IronPort-SDR: MMlmuTK1T+QJUOvPPqvCLA/YYOoxeha2DbB03vzArUZe6FaGbO6mJJAWeLuw5xNhueV5RvhmFQ
 TQUUBeGBnCPz/qqplZp7MRS/7PaCxKsYmuVAvAINpVri7vGJNqvgbd0mL8BxKO8Cskad6qVDDP
 DHOHxJ4bPBoj6M5mNtF7JbEAzMUU53pEJG/lA4vsIrU603zzXWRBLXkHMMPyUl1+d+1qeBjj6k
 5SZDuEk5sGnkUHYsjZsoKh3watOupwor4b0pJzP4tYODLbCZSIlq+cIQlZ7ivLTNClj1ZLP8mK
 uS0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 17:08:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J1D5C6gZvz1RtVt
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:08:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637975311; x=1640567312; bh=JeEh0wBirBhWicGL8pepRh1yqbBvRlV2EWU
        TRaq+jHY=; b=pMVAustdvyr0Mz+RxNV5LsZrFPm9QgKAQb0IG/aGJxfxtHVY+w3
        H2BxSMK++OVJ2+Oxj4xW3u2QJDZRTSpkEOXlIHsF+Y1/vCVQaRYElLyJ7yDo1o7r
        HU1cDXloVUHGGp1NlIL6wuPYIzvdaJxRy4+k0WzyhfWuYaExujnoA4PzrN/NChcs
        a8HvHZvZ0gFpgfKwqw8Rs+naEg6jliUgiZc6KBW4N8/R18Pi+fltwF3i69oW84eO
        dYd34uLRmskRRNUZz0ECbmOUsgutSRipVCo6bl62tUZaDiUFbfTtC5C3uO71+wtr
        D703sBjmg459d0cOSJeEcJ0z0yQ3PClyqdg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j3YoDQyTVAHE for <linux-kernel@vger.kernel.org>;
        Fri, 26 Nov 2021 17:08:31 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J1D5B1dgQz1RtVl;
        Fri, 26 Nov 2021 17:08:29 -0800 (PST)
Message-ID: <ef1c39ab-7b56-6a37-0f4f-1ca111d5b48b@opensource.wdc.com>
Date:   Sat, 27 Nov 2021 10:08:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/26 19:42, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The write pointer in NVMe ZNS is invalid for a zone in zone state full.
> The same also holds true for ZAC/ZBC.
> 
> The current behavior for NVMe is to simply propagate the wp reported by
> the drive, even for full zones. Since the wp is invalid for a full zone,
> the wp reported by the drive may be any value.
> 
> The way that the sd_zbc driver handles a full zone is to always report
> the wp as zone start + zone len, regardless of what the drive reported.
> null_blk also follows this convention.
> 
> Do the same for NVMe, so that a BLKREPORTZONE ioctl reports the write
> pointer for a full zone in a consistent way, regardless of the interface
> of the underlying zoned block device.
> 
> blkzone report before patch:
> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0xfffffffffffbfff8
> reset:0 non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> blkzone report after patch:
> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0x040000 reset:0
> non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Changes since v1:
> - Minor commit message rewording.
> - Use if/else instead of setting wp unconditionally and then
>   conditionally updating it.
> 
>  drivers/nvme/host/zns.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index bfc259e0d7b8..9f81beb4df4e 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -166,7 +166,10 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>  	zone.len = ns->zsze;
>  	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>  	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
> -	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
> +	if (zone.cond == BLK_ZONE_COND_FULL)
> +		zone.wp = zone.start + zone.len;
> +	else
> +		zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
>  
>  	return cb(&zone, idx, data);
>  }
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Note: read-only zones also have an undefined wp. So I wonder if we should not
set the wp similarly to full zones, to match the fact that we cannot write to
these zones. Same for offline zones, but these are tricky since they cannot be
read either, meaning that wp should be set to the zone start for that case...


-- 
Damien Le Moal
Western Digital Research
