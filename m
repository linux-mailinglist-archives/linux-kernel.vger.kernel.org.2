Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6D420233
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 17:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhJCP31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 11:29:27 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhJCP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 11:29:26 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZTVu-1mLUOV3zyI-00WXuJ for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021
 17:27:38 +0200
Received: by mail-wr1-f47.google.com with SMTP id v25so14894715wra.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 08:27:37 -0700 (PDT)
X-Gm-Message-State: AOAM530cKk7VcVvwdQ7m5yOlkj2Ytz27RyMu8A8SAiLArjLNMbEbEFN/
        Fu0zukrOTkDfdECufJ/TlWofLLbrt3dpJz5/89M=
X-Google-Smtp-Source: ABdhPJx555MTqA/6lXrHsT6BxpSfCJdY8NtrEPSUzogliHWkD7nZWhljz+fmDWgCwkYBjzzHM8AasmP64bCKDOBptXE=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr9028120wrs.71.1633274857642;
 Sun, 03 Oct 2021 08:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211002235712.189536-1-palmer@dabbelt.com>
In-Reply-To: <20211002235712.189536-1-palmer@dabbelt.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 3 Oct 2021 17:27:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3-VffaUQmQ=w8CNCEWarm9JFqwEAXrEGqr9Dj3khRV2A@mail.gmail.com>
Message-ID: <CAK8P3a3-VffaUQmQ=w8CNCEWarm9JFqwEAXrEGqr9Dj3khRV2A@mail.gmail.com>
Subject: Re: [PATCH] checksyscalls: Unconditionally ignore fstat{,at}64
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xtW63c6SLd1JkEwnCPZtfWpYyuRQXp9jqEyolzKbjDRLrIUmj5A
 420vhmBSPrtUD0Lv3BkXSPJ4R0IGy9wb5qmgMRthcbcn31GTouHl1uvxX9ePlPKRM+KuyyD
 zJ9U54dl/r9UnFLOycn1IyPMlhheFydvph9/L40vKWqlgyJ91OQgO5y+Ztgawo9RNYX2Xi5
 KmaTN4tgV555gN9rhMvZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T4P+QxGPMY8=:ttwNxtVdETnF1J8E0LPxlh
 VA9IRItKtSUjVDpUpv9ZUW3sGRcVPQriK35AwVXl0JSesn3NPq5pMXjIELXr6ADDm4XGoI6FN
 cBq9IODRhAA0Y/vs9Q885S7Van+UhLDMCsG0ODlIgFq+DIYP99cGTWeV62f+Pc0uFILO89Yl2
 WVCGX+M/8kr1avZ3Wh+QZyGk3bq147TTRPuJ/rySLvADZcRitREM0KJrh6RkkebTSUdQQhqMy
 vyJZefyKihmrzrwnRa9CS/3dsNYlQLLutsZkP2kK/9T1mLjpSgQHSkwopZ7spTjsKTTc0TrGP
 Jrd0AhWkSp3hgAcpKIBzPfUzQd+7PQlzMOGggfyAZj9wg9wwmx+UbUsfi9f0yhTdQ+uV+aJbz
 XU6BFXfoIc4IVa0nvF3OIeNLfwhGzkAo0ipNG6/sSqr8XUgNAvK2ygqKwgdBT6gt9gvUA8aFC
 KXZ657DuAW3wUSvVZwfIq9cBUwsAxl+xyDMirQYWs+N3flsdHd08YiAmDE9euIJQMkFoxxSLp
 VjzrQIzexI8EMDFCVAfgDWXwXEgXNMkX7ysqHqARRNYcjqJxCQKJ9xJjZqQdZ0hNYSw7Ui868
 Go3CFfsFm9taysUwuVpmWOZ+q2P5HKNdjQhwUcfaJN1ddY58hvPEQOHtUeJ2OHOjgYPSHjsAe
 veyil0AZi/dyfRLwEx0C79lr73YY1cRhMOnKrDKie0Rr6z6BEVfQ3jLTlTMbKmm2mR+OykViJ
 2TnTziOPxaN0+JIG3ui1icmDG99PFlqfLimZEw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 2:56 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> These can be replaced by statx().  Since rv32 has a 64-bit time_t we
> just never ended up with them in the first place.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> Happy to take this through the RISC-V tree, as it's fixing a build warning
> (that's being promoted to an error for me, not sure why).  I'm just not all
> that familiar with how this one works.
>
> Arnd suggested putting these here, but not exactly doing it this way.

Merging it through your tree sounds good.
