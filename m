Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B461244F2A6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 12:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhKMLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 06:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhKMLJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 06:09:56 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B516C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 03:07:04 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 131so30801923ybc.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 03:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSwBIpAKOvKE9/HfMni6vvyfMrUyqVOn+Ln8uGL1xcQ=;
        b=lmaLjcu6MnsUaKTfJOWQ3NCLah2twVb8rnhqSvRx1VtxjI9xCQ9Ao9/XFIWVKb/HLf
         K5HymG0R5CrZ930OT/c7NdRoI1z9iefbZZ82mVxzfmi5N019vVwam3rY0k9vR9qtuF4j
         II3m0FZW3u9w6RtUpOD5sS9iul4ax2s8WsCF7Bz4t0Hjzsz/AmkDfuEatFMd1z3YbN5/
         Ndw9ECBPcD1XwYRwdl8aubGwWXO47Fxc+XL9OFJKOONAUaqWAvDlGxAJJCXW0X8axC3D
         HEMvlHtxpeOmJNaeP64EcJQs1YgccppntT5w6gjnQRp9P9srtvXxxE9I9wo2HI0yegGH
         q2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSwBIpAKOvKE9/HfMni6vvyfMrUyqVOn+Ln8uGL1xcQ=;
        b=6u9mBnc/U1Udpy7jbxUAa+Fkd/X61gFBCnHK1g1yH6lbUWhlcQ+nJsk5GEwIWHJrxM
         96/fEkUG06x8xlsnnh+Z840HMNzHfk2uQ02YtvMt12ciuqMRZkToTRAeQG3nhN/stz9S
         FYAklox2NpouLZw1+p0JSHWu5DLt0nZoR7D/prt5EUttbSRvxw8hYLEXEY34qv8HW/uA
         /s+VF+BwFqxY8gTm1zbCqpPa22YFBq6InX6S6EfFzn196yTLmoIZiAcZrh6q/pIlWdtt
         7bAYNQvgW7HCV2t2Zkm+9bt06P1lKHwv32DBeesuRpiHO151bQVCIVNdaerSNTMsDjBF
         ErIg==
X-Gm-Message-State: AOAM532crAVeRbg8HAPVpeRzRMOlBoMdIG1/4NHbMMunN5VLw7aaoOUV
        LqLO3Yjla5cS45SZtaIw75pxho3/7L/t7805tD4=
X-Google-Smtp-Source: ABdhPJyJSJBgIErAQL04cOmL6TrLYrxEMcCzqyulHgBnnK1s8n2Cg7iTYX25GttsV+7OTFXS7M+xXNQnHUz1qgHPDo8=
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr23978411ybk.403.1636801623864;
 Sat, 13 Nov 2021 03:07:03 -0800 (PST)
MIME-Version: 1.0
References: <CADVatmOuOk6RoZF=M9sZm2L=9NuDDsSNNCJJbAtkgScG0og1Ww@mail.gmail.com>
 <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
In-Reply-To: <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 13 Nov 2021 11:06:28 +0000
Message-ID: <CADVatmOOzCxAgLhCu1tTz=44sgRDXds5-oMZ3V0w4f5kLCLKrw@mail.gmail.com>
Subject: Re: regression with mainline kernel
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Nicholas Verne <nverne@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 8:51 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Linus,
>
> On Thu, Nov 11, 2021 at 2:03 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi Linus,
> >
> > My testing has been failing for the last few days. Last good test was
> > with 6f2b76a4a384 and I started seeing the failure with ce840177930f5
> > where boot timeout.

Last night's test on 66f4beaa6c1d worked fine. So I guess this has now
been fixed.
Thanks.


-- 
Regards
Sudip
