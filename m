Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3430D3AE707
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFUK37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:29:59 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUK36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:29:58 -0400
Received: from [192.168.1.155] ([95.118.106.223]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mk0FM-1lXAgQ15NA-00kNZY; Mon, 21 Jun 2021 12:27:42 +0200
Subject: Re: LockDown that allows read of /dev/mem ?
To:     "David F." <df7729@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAGRSmLvaZ7av7ne-XKfZGrij1x9i5v1aH=t0ufL=Ad1193G0vA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <99e0ef5a-156f-c8e5-cfc3-7c50e5e15a98@metux.net>
Date:   Mon, 21 Jun 2021 12:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGRSmLvaZ7av7ne-XKfZGrij1x9i5v1aH=t0ufL=Ad1193G0vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nFO2JBTQkP3ieWeKK9VmghH2rracDNY2weGmzNK0fCv8dWxYQX1
 K4O7XWfwVhL9jYpqqJLA1rFPizFzbciFwPirF57elEdYewqexyY21oEBndh9dTOt6BKdKLA
 kcmZz2agy7BX9GiyVok0nCqbDX4Pp7eIFJD7pACHJ/zXvXdA+9WAkTkQa6DNK/EyeipwsdB
 qv+YVFdx6IEi6On/UN2Ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UngH/ZoRFMs=:dvlpNgLi+yj4/FnZq7aihR
 XTKDpQrzhe/aBZ7vKGO0+6K74wmoQsy+247m0JVlsUVXNCnZQNb4bT40NA0SqlqccjCdyiwql
 AwxBy5K3X7vkabOmzluvbbbh8Uw6uV2aaVIaoGk7vfGesNwp14EMgWRxhxGR4S0VEuMyfnu8P
 6qptTlrGYGsdj0lXHcRwBVHhsCEmoUwh/rdTSb6eHc2vnHIfIzKVyGFXYd5hgg59rogh9JmX5
 3JUntoWBoV1+0mxoC4ew2Tgw4G/h6NoO9NHuDbgZJ83cuIWqqH6mai7A52Xhc4amjmtyqha1o
 DhsfD7sVeBBzzOLpNaQ0aa1nH/n+EUs13SqbbkOcrwMpEa54HX0B5yJVf/tZ3/KxCLZ4PaFdp
 xEW8J4Sk0zQ2S7OnwjchhSVLVIHBT2NFFIIyWjpgvyKj65MpiDE0h9fVm4qyorSCkywAwro0K
 tAnHgB+cc8yZZkaYDWzXtTwf+W7TIGBEl8REb5652hUxvdIgoezAwAcMvAcbTsoVZZIcL50zt
 owTeICkJlT3fVJypa9GF9w=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.21 01:55, David F. wrote:

> I'm finding that LockDown Integrity prevents blocks things like mdadm,
> Xvesa, and a couple of my specialized tools.    There should be an
> option to allow /dev/mem read access.  Is there?  There are no secrets
> to the boot disk booted environment it's all root.

Looks like conflict of goals. lockdown is used in scenarios where one
really doesn't take any chance that code running w/ root privileges can
do such things (there's a lot of security critical information one can
learn from reading the raw memory).

I wonder what your actual use case is.

* why are you using lockdown and also running everything as root ?
* why are you still using the old Xvesa instead of using KMS or
  framebuffer device ?
* why does mdadm want to access /dev/mem ?



--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
