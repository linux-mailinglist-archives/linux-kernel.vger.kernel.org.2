Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3025339F1B1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFHJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:11:47 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55687 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFHJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:11:46 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MMoOy-1m77Bs25Po-00IhyV for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021
 11:09:52 +0200
Received: by mail-wm1-f44.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso1397250wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 02:09:52 -0700 (PDT)
X-Gm-Message-State: AOAM530zmTmECNIBLCoQErv9WB8OorA5dKJKqhNzSg0NzeEGjWQfo2fy
        fKiaNy4PxhGJYN1kYLS7Jv/gCfvrtK1LW2rxhKQ=
X-Google-Smtp-Source: ABdhPJweH0NoDFNEsagQCwbebQZjm1ygLiKnMTWz5Pn2SQnkv8GB1qQnVdqz+Zsumft6G8Lt0mk26k1PBwGzVIU/TC4=
X-Received: by 2002:a7b:c849:: with SMTP id c9mr3166270wml.84.1623143392139;
 Tue, 08 Jun 2021 02:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210608085513.2069-1-mark.rutland@arm.com>
In-Reply-To: <20210608085513.2069-1-mark.rutland@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Jun 2021 11:08:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04_Xu+qv-Smtpnbw8iTkfWqiYP9+YE5pA_T+gsNGVVcw@mail.gmail.com>
Message-ID: <CAK8P3a04_Xu+qv-Smtpnbw8iTkfWqiYP9+YE5pA_T+gsNGVVcw@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: fix vc4_atomic_commit_tail() logic
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Will Deacon <will@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mSp6XqwYFhGyvGexCNpHFdsAPIi/o9nK+1dnUbV79EmDE99ivlV
 Ee1gw8WvDdUtH4/8HrRQSuypZyTP4P5eGM7sOqj2d69Cs9a9rObTsdRREQKhlU6Q4VVTjyR
 JbNjAT5iHjQ8/NmffLfFK2D18R4AbHZUUXVI5bXjH1mALVh8lbVdVG4Akq1Q+RZ4PUUnZL5
 P5XEJbA+I4OXPm64MBbRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tkm3w43ZM9A=:pwzK7L2bYbCrrmufpgA+Xk
 cDMbx+Npax6oAxcAB69aRLrC/ELKqgXJu0jEk6gehG5Rxud8aStbGOSX+GoMIrpHUM/d7jo+F
 y99XvPyEfj0m2NXR+hxIGidpSi9O9REi1/WQ2FTJ6e8B0ec5A+fP5papFPEWjaONngpA8Z0IH
 nxIwROYH6dWEozPbrEkJuKP8iTQBONAEAOVSMb/3Mna5nc6JqnqukdX/7+uStrla66Jy+Ydg8
 Si0JZWGZv7eZcmcnYiNRz6ZK6xxAVLUwa7uyVfF5eOOG1/iSpf92D2BjZeiQ0JTw452pEF5cn
 HrMR9XX6hgFCskb8oWB/1Rl5I5BPPIHWhhyczen1HWe0RbCJ1ckFGgg6V7ngied3J8Dbvv6ab
 MFTJYauZ5JTPsyZpDwya0O6Fl7yNR1LALS7SN+cYfP0qcl6qrZ4UMb5St/RVFiChUT16aLYZd
 zSBkcSg4r2YRkMi1NuHXQ2Xrgd/RiObXJm1MPzh2QaUpbSPV5tiGuytiridGbl5lg4B3mK/O4
 Ev/gLLltzB2Qp8OmPDpyRg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 10:56 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> In vc4_atomic_commit_tail() we iterate of the set of old CRTCs, and
> attempt to wait on any channels which are still in use. When we iterate
> over the CRTCs, we have:
>
> * `i` - the index of the CRTC
> * `channel` - the channel a CRTC is using
>
> When we check the channel state, we consult:
>
>   old_hvs_state->fifo_state[channel].in_use
>
> ... but when we wait for the channel, we erroneously wait on:
>
>   old_hvs_state->fifo_state[i].pending_commit
>
> ... rather than:
>
>    old_hvs_state->fifo_state[channel].pending_commit
>
> ... and this bogus access has been observed to result in boot-time hangs
> on some arm64 configurations, and can be detected using KASAN. FIx this
> by using the correct index.
>
> I've tested this on a Raspberry Pi 3 model B v1.2 with KASAN.
...
>
> Link: https://lore.kernel.org/r/4d0c8318-bad8-2be7-e292-fc8f70c198de@samsung.com
> Link: https://lore.kernel.org/linux-arm-kernel/20210607151740.moncryl5zv3ahq4s@gilmour
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
