Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4423C9ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhGOIiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhGOIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626338114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yi9obYV2IFRXQcU5OjCWyacMaSnPkoEY5XTUowFAJiA=;
        b=QY3UlvQKTFBw7KtnAyfarbb15LRCTHoH0yTuLS9YPQRTjQN5a8D67n5VSzZCQBrSaIVlB9
        4QSS62jW02RiTVBCtFix4bPKuNiWm0dg+zWehbW0ZDRKrrsjzUKkb6iF4PotkLuK1pqvHj
        LPcHAETy0pkz7ZqV9MFbPY2yfjGqu+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-0g8kaB68OsKvOYvFLiSMiA-1; Thu, 15 Jul 2021 04:35:12 -0400
X-MC-Unique: 0g8kaB68OsKvOYvFLiSMiA-1
Received: by mail-wr1-f71.google.com with SMTP id z6-20020a5d4c860000b029013a10564614so2982502wrs.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yi9obYV2IFRXQcU5OjCWyacMaSnPkoEY5XTUowFAJiA=;
        b=MHTnHBMJ2tWhwblBIIhVPWffspDc+57Z7WSUh2IAIrnjRtyzOOxRPE+aulOgRha48K
         aFsxwMXaRLo/yMZiDyuDRBglJJ2lpUH36G50i8CZq5eJmNk5Sqrwq8e4Nke+/faYv8Us
         KsDBizctTkSPdBNtEuc9C//X6kLAMRVxS919B+26CriwwNdf3Ll8zh7TXprHPL43G1Pv
         0qcKiIzIHrXNOL75cJFRNsfG+0fxHMLmT3kE9ulkiQuguuKOPEiaf2bbKQT+7EchEmPO
         zs8l/A9Un75lDJxWgRw8/8BEHGygXrrntc1/DQz/s2Zieh0AR5aYh2Si4JLGqfeC2Jnk
         po5Q==
X-Gm-Message-State: AOAM531S4szNwdkgI5S+zRS+tq9tA+C1yV/OojqFanQGSi8pbjYzBOpP
        gsgSRBWTat+jYk9LtUCSX/t4CE3eARVdzS5KdvH/djgwLxJnypqGxm0pXNmsNhfhflyB4p5ZNQP
        nseIODjURI+m64Lla95ARK7iH
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr4007232wrt.126.1626338111390;
        Thu, 15 Jul 2021 01:35:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOcHackGTT36UUmS+7YRBiz7L/liYJnRUoJLQrhvcqPYVpB5MzgW5RyeKFX9AYIL0Pg+nx6Q==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr4007203wrt.126.1626338111178;
        Thu, 15 Jul 2021 01:35:11 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id d10sm5342281wro.43.2021.07.15.01.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:35:10 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 4/4] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
To:     John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, acme@kernel.org,
        Jiri Olsa <jolsa@redhat.com>
References: <20210713152100.10381-1-mgorman@techsingularity.net>
 <20210713152100.10381-5-mgorman@techsingularity.net>
 <fb642720-b651-e93f-4656-7042493efba8@nvidia.com>
Message-ID: <5db9011e-9b52-b415-70b6-c7ee1b01436b@redhat.com>
Date:   Thu, 15 Jul 2021 10:35:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fb642720-b651-e93f-4656-7042493efba8@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc. Jiri Olsa + Arnaldo

On 14/07/2021 09.06, John Hubbard wrote:
> On 7/13/21 8:21 AM, Mel Gorman wrote:
>> From: Matteo Croce <mcroce@microsoft.com>
>>
>> This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.
>>
>> Fix an unresolved symbol error when CONFIG_DEBUG_INFO_BTF=y:
>>
>>    LD      vmlinux
>>    BTFIDS  vmlinux
>> FAILED unresolved symbol should_fail_alloc_page
>> make: *** [Makefile:1199: vmlinux] Error 255
>> make: *** Deleting file 'vmlinux'
> 
> Yes! I ran into this yesterday. Your patch fixes this build failure
> for me, so feel free to add:
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> 
> 
> However, I should add that I'm still seeing another build failure, after
> fixing the above:
> 
> LD      vmlinux
> BTFIDS  vmlinux
> FAILED elf_update(WRITE): no error

This elf_update(WRITE) error is new to me.

> make: *** [Makefile:1176: vmlinux] Error 255
> make: *** Deleting file 'vmlinux'

It is annoying that vmlinux is deleted in this case, because I usually 
give Jiri the output from 'resolve_btfids -v' on vmlinux.

  $ ./tools/bpf/resolve_btfids/resolve_btfids -v vmlinux.failed

You can do:
$ git diff
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 3b261b0f74f0..02dec10a7d75 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -302,7 +302,8 @@ cleanup()
         rm -f .tmp_symversions.lds
         rm -f .tmp_vmlinux*
         rm -f System.map
-       rm -f vmlinux
+       # rm -f vmlinux
+       mv vmlinux vmlinux.failed
         rm -f vmlinux.o
  }


> 
> 
> ...and un-setting CONFIG_DEBUG_INFO_BTF makes that disappear. Maybe someone
> who is understands the BTFIDS build step can shed some light on that; I'm
> not there yet. :)

I'm just a user/consume of output from the BTFIDS build step, I think 
Jiri Olsa own the tool resolve_btfids, and ACME pahole.  I've hit a 
number of issues in the past that Jiri and ACME help resolve quickly.
The most efficient solution I've found was to upgrade pahole to a newer 
version.

What version of pahole does your build system have?

What is your GCC version?

--Jesper

