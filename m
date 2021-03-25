Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5536F349190
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhCYMHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCYMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:07:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E109FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 05:07:29 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id u8so1371423qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kYT3ITsLPoPpWsYn5h5XRyDJBXwfCvVZAljAcGNbjnc=;
        b=PExBHGeQf3XDRWdPLd9QVOEqgEcEmE9x8OiWcgMxTB/E5WqTRXbRhoHAL18Omn35qu
         EO8ltdLUnCZXxccrkHhg+cEGHSUVoW3YFTDRfOFFU4IbDcDFWzLOp9Z5elbD72WVeCAb
         5+D/Xzi0mgWFshqs0aHn8hW1rTZbW5quQ6qppaIx3OKBrezCwbC3aRGwqforPZb6Z8So
         yYyH43jPAUJBYVw/EJtP2p1SNEtKX9vhE+H1xfnqN6fuqGlBxiW0dmxuB0+bntrqt9DL
         bRPPcnLFFWzEweMh2ZFrAV8g2UpWbGTz5Fsn3iwyRxPsTQ+oSpS4Wc6TfuZRl6mb4M/i
         TcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=kYT3ITsLPoPpWsYn5h5XRyDJBXwfCvVZAljAcGNbjnc=;
        b=PgjJZkx+DjdQX0YzJkhoBNb2VBBu5f9QSyJEy9eSnQxfx/YiMtTn+mXknpUW7hjHCA
         1MvG/NiZdReMo8F4RDR+ITlhW6NGytjPGsYK8nMMiFw6KJ7Xj1jh9MUS769Eu6igROOf
         Nei9uPlpg2g7L+WdYQMLC6UiOt2aXd1piF5WX5axhJS8MfCCZF3LST0T1Uhl6kPIEZcD
         scqeCaje7Ff+IZBAIl7zzILSkNL+SYjQPiApKCgRwWD4MF9arPEeHZLISFkGE+RXofxH
         HMUODKa4aACs8rz52qAdFLSaoxJ7PzvktlQxidqzqiOu9vwUPTYJZAw0EIXYyXYVBDMf
         ucZg==
X-Gm-Message-State: AOAM530SJGj+JhAe5TPfpMKRxHXfIyiIqB5iXY+UYfmq72ZrTmZDLHnR
        PmtVQOrLEXaT4aLZosjnzXE=
X-Google-Smtp-Source: ABdhPJymF873pbmqSzUsLuRD42xGR/6NI7EqDjeGJoP725P8hDfxVpCjnrlnFJqXWdDXEiDjWzDwOw==
X-Received: by 2002:ac8:5a42:: with SMTP id o2mr7323604qta.191.1616674049100;
        Thu, 25 Mar 2021 05:07:29 -0700 (PDT)
Received: from debian ([37.19.198.103])
        by smtp.gmail.com with ESMTPSA id e1sm3459859qti.10.2021.03.25.05.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 05:07:28 -0700 (PDT)
Date:   Thu, 25 Mar 2021 17:37:19 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        mirq-linux@rere.qmqm.pl, lars@metafoo.de, gustavoars@kernel.org,
        huawei@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH V3]  ALSA: pcm: Fix couple of typos
Message-ID: <20210325120717.GA9273@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
        broonie@kernel.org, mirq-linux@rere.qmqm.pl, lars@metafoo.de,
        gustavoars@kernel.org, huawei@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210325090609.10372-1-unixbhaskar@gmail.com>
 <s5ho8f7mv5k.wl-tiwai@suse.de>
 <20210325095617.GB32566@debian>
 <s5hk0pvmrwp.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <s5hk0pvmrwp.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11:47 Thu 25 Mar 2021, Takashi Iwai wrote:
>On Thu, 25 Mar 2021 10:56:39 +0100,
>Bhaskar Chowdhury wrote:
>>
>> On 10:37 Thu 25 Mar 2021, Takashi Iwai wrote:
>> >On Thu, 25 Mar 2021 10:06:09 +0100,
>> >Bhaskar Chowdhury wrote:
>> >>
>> >> s/unconditonally/unconditionally/
>> >> s/succesful/successful/
>> >>
>> >> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> >> ---
>> >>  Changes from V2:
>> >>  Takashi pointed out that the patch was not applicable due to some un=
wanted
>> >>  stuff get into it. Resending it with the new patch creation.
>> >
>> >Hrm, still not applicable.  Can you apply the patch from your own post
>> >via git-am in your side?
>> >
>> Here is what I do for this specific case :
>>
>> =E2=9C=94 ~/git-linux/linux-next [patch L|=E2=9C=94]
>> 15:18 $ sed -i 's/unconditonally/unconditionally/' sound/core/pcm_native=
=2Ec
>> =E2=9C=94 ~/git-linux/linux-next [patch L|=E2=9C=9A 1]
>> 15:19 $ sed -i 's/succesful/successful/' sound/core/pcm_native.c
>> =E2=9C=94 ~/git-linux/linux-next [patch L|=E2=9C=9A 1]
>> 15:19 $ git add .
>> =E2=9C=94 ~/git-linux/linux-next [patch L|=E2=97=8F1]
>> 15:19 $ git ci "Fix some patch error"
>> [patch 88d5af187dbb] Fix some patch error
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> 15:21 $ git_fetch_single_file.sh sound/core/pcm_native.c
>> Looks alright!=E2=9C=94 ~/git-linux/linux-next [patch L|=E2=97=8F1]
>> 15:21 $ git add .
>> =E2=9C=94 ~/git-linux/linux-next [patch L|=E2=97=8F1]
>> 15:21 $ git ci "Bring for patch"
>> [patch 352e1ce8dacf] Bring for patch
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> =E2=9C=94 ~/git-linux/linux-next [patch L|=E2=9C=94]
>> 15:22 $ git apply --verbose 0001-Made-patche-for-this.patch
>> Checking patch sound/core/pcm_native.c...
>> Applied patch sound/core/pcm_native.c cleanly.
>
>I meant to try to apply the patch from mail fetched from the ML, not
>the patch you made from your git tree.
>
>

Hmmmmmm

bhaskar@debian_16:18:41_Thu Mar 25 :~> mutt
Applying: ALSA: pcm: Fix couple of typos
error: corrupt patch at line 29
Patch failed at 0001 ALSA: pcm: Fix couple of typos
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
Press any key to continue...


Something bugging it ....
>Takashi

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBcfPEACgkQsjqdtxFL
KRW03ggAtQwsG2J/1kiWlNSs6QF37p9WP/jvZTyvpfpH6zzH9GGbgd7s2NZVBbOA
6q0l86QrWe+gIvN2/23LygXUWFPXiF/eFxYU+2g7Ir2eg6mV7RSNbc7KyTHP75ze
CNwt6KpvyUD0HKMWgclK+TJU7+VNNO7pMPJ3O8vJCMiujzRLK+zsMbUx4l1OjLnl
qr5siOqzXmgrt4wgb1WIvYiZDCBcTOqQT5WoYbFp3Koy0sLcRVk5JP20IRlw28Q+
4BIk4FCJfC5X+wAmb1xQkpzIaNiYCEnfRvMJKbk6BVWWZozGnEudQoaDScpFlyRK
1mFQQyWy6a5JEyKiXu6zppy42ZbeKA==
=G0p9
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
