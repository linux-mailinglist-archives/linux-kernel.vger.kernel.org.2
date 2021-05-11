Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8F37A9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhEKOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhEKOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:54:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C9FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:53:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a4so30240242ejk.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=taLonWEHUFMpxXMU60wQyJ5XuQkg0OX8RWCfQzUPJ7o=;
        b=KFezSXLkO2sHs/zAiyEuEsZpt7FwPW738uHs7yBZ5RrNDQ7l5HwiABdMfDfzYJak0i
         O98xlr38hTdNTf6tJyZWBLAm5i29fOsa4DlRv3fZKJksyIVH7sM5mMXuyoQtQdw8V+L7
         1p6cTmt0OoeuuJzta+iTENQ+NWjdx/z9EqBFTwwHa3DNq7GhgLpFHemcth42ual0ciiH
         d6kqHHMj2tu8KAvvdMDVmf4aJ2bVY2AELAC4UatfR/UnznebwTyL65uQjAX1hiAlN2Ia
         Z4VYpqbNot2apAOqxXgfLYeqXFkR4hIcfLSte0+xY9l1CBlfvqs1DYf27khcw5A/qF3J
         M2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=taLonWEHUFMpxXMU60wQyJ5XuQkg0OX8RWCfQzUPJ7o=;
        b=oFND4NdXSbPYEzjgzrt4AslKqW1KZQVnzrsfqD1ka89uMfrU7lAAmoOUBJQIAQCgoT
         iZ0uC2VyTazlzR39ABjr66EWWWK40m+QaP8hrpmH1f/Z16MbNOHa+OiiNlFH/HsmdvLW
         edy0v4YuFLh8jy+wpGJx+KR5U9X1WnDb7KaR8TU25BH+oNHbZYG54G/d4axLUC6P2yx1
         ksNo60OqtmX/wAqGUg1KRU/CnqXqxtZSOM9Q3k0FzJNsRQcjQYOXhbwtRfS9PiVSCVvP
         aKFjoU3g5HnBKlPlPu+VoZAEzJZ/v3yWzOT7IjlA7OpLEjKg5jDQJT+jbOBIR6f7SKtT
         L72A==
X-Gm-Message-State: AOAM532x9lTeht38g1C15hcpKYpXYMEj0DD5KbZIhFl2kzorHlOy2nWR
        +yCVtCJPDyeCnkFg1PZMCbsMLFxltzvWXjt5
X-Google-Smtp-Source: ABdhPJwWWjtVUTwhsjCA1OE3X3hVuHufzQBBKlmL7agdW/bPGgkaJuvkTBQsC0lMrsE0Zt9sd7XNhQ==
X-Received: by 2002:a17:906:1701:: with SMTP id c1mr32219599eje.425.1620744801819;
        Tue, 11 May 2021 07:53:21 -0700 (PDT)
Received: from [192.168.1.204] (host-79-47-116-73.retail.telecomitalia.it. [79.47.116.73])
        by smtp.gmail.com with ESMTPSA id u4sm1000077eds.1.2021.05.11.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 07:53:21 -0700 (PDT)
Message-ID: <475860dd2356cacc17d24fa32fcfea7823152ce3.camel@gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Add fixup for HP Spectre x360
 15-df0xxx
From:   Elia Devito <eliadevito@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 May 2021 16:53:19 +0200
In-Reply-To: <s5h1radcrjt.wl-tiwai@suse.de>
References: <s5ho8dhd4b3.wl-tiwai@suse.de>
         <20210511124651.4802-1-eliadevito@gmail.com> <s5h1radcrjt.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno mar, 11/05/2021 alle 15.45 +0200, Takashi Iwai ha scritto:
> On Tue, 11 May 2021 14:46:49 +0200,
> Elia Devito wrote:
> > 
> > Fixup to enable all 4 speaker on HP Spectre x360 15-df0xxx and
> > probably
> > on similar models.
> > 
> > 0x14 pin config override is required to enable all speakers and
> > alc285-speaker2-to-dac1 fixup to enable volume adjustment.
> > 
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=189331
> > Signed-off-by: Elia Devito <eliadevito@gmail.com>
> > ---
> > v2: Put the quirk entry in the PCI SSID order
> 
> Thanks, applied now.
> 
> 
> Takashi

Thanks for your time.

Elia

