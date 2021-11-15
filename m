Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7129E450112
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhKOJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:22:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10310 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhKOJVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636967907; x=1668503907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tdJIZez96uAYSrf9+CutoTspckmKf1T/muIr048hnOA=;
  b=kr56joOl71lHClBGzVc68fXDQNysEy05NAo2CMQf5wWKopZNk6GXcQ5L
   5F97DxPKka122bJeggieXjhAmLcF7SPn/g87H5SdHPOy7g9ENd54qzFwj
   c+7RvxgTtpAZ+7gD03Yh7kWaqy7JNG2EPzha9+xdi3atGTbS5PO+wiILv
   8ZTZ/u9jYBHUZsYnzOVl1Bvrv0ttgLRFnwAFJTVDkOfxNS9dMQI4FgstE
   bS5w00fxXX2wUhsrIzXGQfkZcttw4/bJ45tIbeb9nBcVlrn0XoduQYOiA
   T1LaMNs0EyFh/Rj90tLKycxagV/Hi0AQAYDJgfKe5Esb1jBh87NEa7h4R
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,236,1631548800"; 
   d="scan'208";a="186615403"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 17:18:27 +0800
IronPort-SDR: PDtTQWVyyhapBSj/Gd8pFCu6nczqGAPEL9nAw1TqBDOi9eZKeI3bajk5WI/REVSzxTKVFDsRuG
 jm7tcCCBsPJoGgIVsFwAHXl4VejU5ykbnOrTQdUWhLSf4B8i2B4BPFos+33v624EtyTM7b445K
 x/Q0+P0buvvSEzNSqqyjU0u247PCYl3hanwsNIyb8rfhlQXuif0q0XXt08jk0oP6LZasieoqvL
 7Tka1CBa1RpqoCgFVWkOSn7LRYYpQKXF0HQzkDxPXqyyFEpSdRx3XTe3iTBuUmroTKxKWZ/FfR
 SaydjEa17+oAzi1Fmthej6O0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 00:53:31 -0800
IronPort-SDR: xBSIndV0CfeqUtFWxyNBzferWelO7MS7FO31tVCfHNMoalMiQG2496UVJxYBAjp2HTuqY074eT
 oUZrCtQ/tKwjjaa5kooOn9JqmL/e2wGoX4z/WKNVKfH/JdAXh/rRtKSAETs67YpbIOUIXdrS0z
 Rs4N5r7u5Cm8A1Vh7gyTRKRutVywRRqE7qJHcHke66y1wgUINDEhogYWNXbhSwkqneYUtG3Pjc
 Xo/5OUGkNdJ5boqSUpSrI3DOhj5sYlZ8T0MLK5OQ1uRJIQrJJV3lHWv0Wm3eue5tuZ9nFI2cr8
 htY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 01:18:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ht3X14Mcyz1RtVp
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:18:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636967904; x=1639559905; bh=tdJIZez96uAYSrf9+CutoTspckmKf1T/muI
        r048hnOA=; b=fmJXsnbRskqadozXiIyT9Ley1xkguQc9gGC3/13Gtr5kIGDtumx
        lAKOG8W2yb8gKi2h9/gCLwl61kihQIy+UBBici9A4PKKVK1p5yz3p9I7i/+G4ISX
        uSfQGzgaBILdNX7wsA38aFszkahdnCe82gDHeN5xwB8mSxNEeNc0aXBUZZEb/Z0t
        ejJsAWCKjsDPHLvoapgdbgdE8cTqzWm+30ZIpQYbi66jaMRbsN3Pcr8YFp12D9f6
        Fh+awUMvxeI7huXPwYxvI1JFWEbRyc4Gj+0qF85+pJ4vIkbMWS2q04hzqXytAC6X
        E2W2vqu6Q393RcNau82HZ+qLuhlR9fNv97A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B9pJwV1Y5V24 for <linux-kernel@vger.kernel.org>;
        Mon, 15 Nov 2021 01:18:24 -0800 (PST)
Received: from [10.89.84.145] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.145])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ht3X02qdqz1RtVl;
        Mon, 15 Nov 2021 01:18:24 -0800 (PST)
Message-ID: <b386bdc4-db27-3160-80ac-ecd9d8d69c9f@opensource.wdc.com>
Date:   Mon, 15 Nov 2021 18:18:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: PROBLEM: [drivers/ata] Read log page failed (boot error message)
Content-Language: en-US
To:     "Nikolas L." <knv418@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YZABtvQab/M2CCQd@msi.localdomain>
 <14b22c98-dc4c-fe3b-fa20-b3dd78afd5cc@opensource.wdc.com>
 <CAMJR_v6igrNZMzXpio27PpA6rQvo+efAVd2nM5GNg2+agQa9=A@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CAMJR_v6igrNZMzXpio27PpA6rQvo+efAVd2nM5GNg2+agQa9=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/15 17:14, Nikolas L. wrote:
>> This error is not fatal. It simply means that the drive does not support the
>> INDENTIFY DEVICE log page. Nothing to worry about.
> I suppose it's not the reason to log error, maybe warn or notice.
>> Attempting to read this log should be avoided in this case though. I will send a
>> patch to fix that.
> Thank you! Got it.
>> However, the files you attached show that you are using
>> kernel 5.12
> According to almost any file in attachment, I'm using 5.15.2.
> Error happens only since 5.15, tested on 5.14.16.

I posted a patch:

https://lore.kernel.org/linux-ide/20211115060559.232835-3-damien.lemoal@opensource.wdc.com/

Can you try it please ?

>> You can ignore the read log error, unless your drive is not functional ?
> Yes I can and I will. Entire problem is just about redundant noise
> with error level in kernel log.
> 


-- 
Damien Le Moal
Western Digital Research
