Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C733739ECA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhFHDDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhFHDDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:03:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64CC061574;
        Mon,  7 Jun 2021 20:01:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c12so14641380pfl.3;
        Mon, 07 Jun 2021 20:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4zyzSgjehYpTMwvkMAdkEk8UOEiuBvRn+Lbe9JMcg3U=;
        b=KmwLevrVyZBLk+TmP9kkEbneRprDD+cTDc0mI24ZPzZmmSOvZrTtua9iRD/F86olxj
         XQxcHOeBpFNwsT9mafmBM5kWyJ5XrWUflmotaFtnE7CrU+ZNcSTaL+MwfZ/XEhPwkqoh
         tFMfhaAChKjg9eh1pl1MkH1RhJtk5qjpF56DA3DJsM1Ch/LcuBuocp0puIiG3kwKqHUm
         UWfOYdYCU/z4HKw6sRU32qcaLzeoAFtB2Dj9sJGsoJuDoRumahYiN8zrIbcjhQxmxO4R
         T6cDnViulSmU4/FnHqs+kV1rZL5UoNK/Q/BAVrKvzVrc0muqKf+yHnUpydwdsMJPp0CX
         jzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4zyzSgjehYpTMwvkMAdkEk8UOEiuBvRn+Lbe9JMcg3U=;
        b=ZSuETvkqE58LrigtXRsIeLnCu07eCHZFpdHVY7kjJDmdunZtNw8jaCyO5dBIzP4me7
         aOA+/QLBnDy/JYtGSiyKRFe5EkVr13ehmfayWd4mebwkKMpFIG2S6ZcPnLibUjWJcH0w
         v6I8pRRP4m8V9DunVBRDHHOx0v3EEjZwsSRlohDQnoowxj+8+MvjjWOLAwFq8o0McLHi
         bxV/Lm4vWSlu84moW46+9nlqvWPgODe7Q/PyV6Y2IcK5N1jPLvCRjQGWNGuHj5IzgW8D
         ktx5XLKJc78PbhSdHK99jN3Zfa9ddYZOqmCsgc3JGx7hJ3pAkgqlf7Z10A9IU2va/BmV
         x2bg==
X-Gm-Message-State: AOAM533IrF/NE5LQgcDMowNH2DRConNdLqEAvdBJW0FlodUkylnQcQsR
        cVCkjzYG/qlk18irdfXH1krLJ7xE7M4=
X-Google-Smtp-Source: ABdhPJyvDlTti6C1rnpagcKLHVsTYa+kmn9kiphYRNiQIyDb3KlqCPzQXCo032VmJ6SiL+ifXjSD1w==
X-Received: by 2002:a63:9515:: with SMTP id p21mr18889215pgd.333.1623121297946;
        Mon, 07 Jun 2021 20:01:37 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id s22sm1671639pfg.197.2021.06.07.20.01.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 20:01:37 -0700 (PDT)
Subject: Re: [PATCH] m68k/q40: Replace q40ide with pata_falcon and falconide
To:     Finn Thain <fthain@linux-m68k.org>
References: <352239036981177050c296ca3deb84a102d9faa2.1622970906.git.fthain@linux-m68k.org>
 <e250cffb-9edd-1b84-3826-58079758b35a@gmail.com>
 <4a32d59-ebb-9dc-fec7-ad172547d9a3@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Zidlicky <rz@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <3b789204-a959-a266-9fc3-1b2be09c981a@gmail.com>
Date:   Tue, 8 Jun 2021 15:01:30 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <4a32d59-ebb-9dc-fec7-ad172547d9a3@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,



Am 07.06.2021 um 14:07 schrieb Finn Thain:
> On Mon, 7 Jun 2021, Michael Schmitz wrote:
>
>> Hi Finn,
>>
>> are there any substantial changes from what I'd tested before?
>
> The request_region() stuff is new, and I reworked the host->get_lock and
> host->release_lock changes. So you may want to review it again.

Done that - the weirdness around request_irq() that I remembered is not 
actually an issue, that's taken care of by setting host->get_lock. And 
your patch doesn't change anything for Falcon.

Tested on my Falcon - I can still use both IDE and SCSI (no stress test 
done but I doubt it would turn out much different).

Not setting host->get_lock on Q40 will correctly request the IRQ for IDE 
there, the same lowlevel IO routines can be shared by both, and there 
wasn't ever much more that these old drivers did.

Please add my Reviewed-by as well as Tested-by.

Cheers,

	Michael


>> Your patch conflicts with (I think) the Mac IDE patches now in Geert's
>> tree, and I'd rather avoid hand-patching the lot if at all possible:
>>
>> m68k_q40_Replace_q40ide_with_pata_falcon_and_falconide
>> Applying: m68k/q40: Replace q40ide with pata_falcon and falconide
>> error: patch failed: arch/m68k/configs/multi_defconfig:351
>> error: arch/m68k/configs/multi_defconfig: patch does not apply
>> error: patch failed: drivers/ide/Kconfig:731
>> error: drivers/ide/Kconfig: patch does not apply
>> error: patch failed: drivers/ide/Makefile:29
>> error: drivers/ide/Makefile: patch does not apply
>>
>
> I should have sent these as a two-part series. Sorry about that.
> You'll need to apply this patch first:
> https://lore.kernel.org/linux-ide/3de9a93d-2f7-a650-1fa-c2129a4a765b@nippy.intranet/T/
>
>> What's your baseline for this patch?
>>
>
> I've used v5.12 and v5.13-rc5, but mostly I develop on the mac68k branch
> in my github repository.
>
>> (In the alternative: just add my Tested-by if nothing changed aside from the
>> IO region reservation)
>>
>
> I have tested these patches in Aranym (including a multi-platform
> atari/q40 build which required your ISA fix) but I don't have any way to
> test the q40-only code.
>
