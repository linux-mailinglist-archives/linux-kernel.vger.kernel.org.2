Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B04577D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 21:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhKSUo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 15:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhKSUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 15:44:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAACC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 12:41:22 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v1so14156507edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 12:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kW7sHYnCDXVSXl0ZtMNxqf1s+pKMyQl4AuTpRTmx0XU=;
        b=bi0plf0WyPpGavgVfV1QtqquuqDxvZiT+Gg/aHjYLY5BLaUOV2UvSKYMgIOXximAXy
         26bRo51hTSr/jTXQ426IiRPXKxg3kgd2RfwZ487TXStcp8WkrBniONM7vfh0PMRMd34o
         ILXihqB3Fo0Ow6FApgF/I94GFarfizNVrWLew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kW7sHYnCDXVSXl0ZtMNxqf1s+pKMyQl4AuTpRTmx0XU=;
        b=bWWRyr/XsQhs6mjPyYJlMlFLOc9v4s5+oc3L5SNtooOJCym8hYX63cBumbckOo3UsP
         BvZqAZJm38z9vkE/kwsWcLTV4hpjoe6UVDeKpWpI7ElWvPdwXe8IB7/TGpNkwqEi8I1k
         HEGXpT1DK+q8fTkF207J0VvWpS+VYW4d5yX7aBukzVxHefer3QWlpUbiqQ3IY+Rb5A/5
         LFT/jeRKyaEiucFQlXlDN33LlplXg8tyOF8kSDTlgfXMhaDaKTp6yOeYSqRbioCAvzRS
         tNGW0hNbFozdaktcW1v9w7YlW2k/DQH3rhI7fojaHq7+8JHJkB2gZcXUysKGfjZKJPTS
         DX7A==
X-Gm-Message-State: AOAM531GabSfs/uu9gFusZKoaRdf5faCa0I2XbTTAMhZveEt2TMyQeT/
        iL7cyBV7ZXo97eag4RTlt+yLzpCoVamdFjcS
X-Google-Smtp-Source: ABdhPJyKSaLlAT0agqgo8vb+xxfVGIvEOA2l56L/BGvzeJIRd6/BcBwEG9Zev3ja6E8IhEaGpB5APQ==
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr17663699edz.323.1637354480692;
        Fri, 19 Nov 2021 12:41:20 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id qf8sm371783ejc.8.2021.11.19.12.41.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 12:41:20 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so3522881wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 12:41:19 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr3304497wmq.26.1637354479681;
 Fri, 19 Nov 2021 12:41:19 -0800 (PST)
MIME-Version: 1.0
References: <0a508ff31bbfa9cd73c24713c54a29ac459e3254.camel@HansenPartnership.com>
 <CAHk-=wjiTXOy3EJ4Eb++umuCgiDufJxrNZ9Z17_NhdORKZGbSA@mail.gmail.com> <af4fd590c7b90e5b3eef13f2fcd0bbb500192d2a.camel@HansenPartnership.com>
In-Reply-To: <af4fd590c7b90e5b3eef13f2fcd0bbb500192d2a.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Nov 2021 12:41:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgVp3m-HDiAPDAXAN0nTs+Fx3onnHE1XRg8cxPnmPw9Q@mail.gmail.com>
Message-ID: <CAHk-=whgVp3m-HDiAPDAXAN0nTs+Fx3onnHE1XRg8cxPnmPw9Q@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 5.16-rc1
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 12:07 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> I can certainly relate to the need to be clear and unambiguous, but
> this is the thin end of the wedge: you'll be telling me I can't use the
> subjunctive mood next just because Americans don't understand what it
> is ...

Please do strive to keep it to monosyllabic words, with the occasional
grunt for emphasis.

          Linus
