Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691C43249DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhBYEqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbhBYEpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:45:31 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E9C061756
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:44:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x22so836690lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KB5JhlgmS5BmydzLq9Py6A6KtaOeupVMCxOq1ee3I5A=;
        b=oEgJPsjr3GwDx4EieM3zreXhqsLnn5vLNP9C7yzu9QqPWSnuZOYOqx4EkFaSCmmVpn
         PSFLqxERn6xBdsKbFbBd3/6gn+dY5wHpga1tMediFaG2wVxW8zMzjeQfohqk79jJmmmV
         5bE5xBWSXTXelmjDJMYlabAZVqtwmIWq4rGTm6M6LsRXQf501d3lYYAdFHyqeOeAhCEY
         dx7KHxjIF+QVDulG+RUcqSKUn6YI3QnLC/Y7xNA2eTfOC8rAxkq1fyxCdPepwkj50tin
         9eEjaAjSPwc0DDMaSrg3SHogJODdP1nroIHZ2HEI8T8ReHNnZiwpQkc6hch6etkQokru
         93QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KB5JhlgmS5BmydzLq9Py6A6KtaOeupVMCxOq1ee3I5A=;
        b=ukMdDnhMLH9RwsV92E+nVa4MAgZUzznOerS6TzlutnpC9nJCN8ybtoLegheRMSkqd4
         xgsyWg7RnFf4LUQIqKMel8r2rRfsra5toyBIq3wSoKPB6r1Ea/zSJKUP5J6qvXfQQ39S
         xPz7MVyxftCAB9Ul3JbpkJpihBTwvq3gokbgorpBA4if7voQTCO31bwJm2P0mZHFbw31
         kY0+zLwxtzStmLCMnaBRrr0wNx+WTDP98tz8yJiRLRg8+szX+2pU9DK01/b+fDct29WL
         wl4HgXpfgtju6RaxO/1H05YjQg2uu8OCxJsD9kPPIV9tQXNZ0tt5jNLBglvgiaJnAOqi
         Y+Mg==
X-Gm-Message-State: AOAM532E6YwrgCIDfnbY3j/GV8faqoraiL+td3Yv66ujHGMOkbGLa+8K
        E3Zb7XqwK1B/OWaMK65CE05R2VgNP07tLJuRfJFEYA==
X-Google-Smtp-Source: ABdhPJwiUGaO+d+ipUZgM4gZGa9mAQUnDYLyKbHj9CJRH/M9xve9lAOtTkPa2TIsSPpduor9oqxQpCj+fadwB6R7d6Q=
X-Received: by 2002:a19:5609:: with SMTP id k9mr774375lfb.589.1614228289206;
 Wed, 24 Feb 2021 20:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20210225040032.684590-1-lzye@google.com> <YDcoduCkBjC8EM3F@google.com>
In-Reply-To: <YDcoduCkBjC8EM3F@google.com>
From:   Chris Ye <lzye@google.com>
Date:   Wed, 24 Feb 2021 20:44:37 -0800
Message-ID: <CAFFuddKYhOV8NY9vqrmzRNe0P_n0H+zzAMarV9iGc_qt=+40xg@mail.gmail.com>
Subject: Re: [PATCH] Input: Add "Share" button to Microsoft Xbox One controller.
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Chris Ye <linzhao.ye@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,
The latest Xbox One X series has this button, I can add a new
XTYPE_XBOXONE_X and only apply the change to the new type.
The controller supports bluetooth and the HID usage for this button is
consumer 0xB2:
0x05, 0x0C,        //   Usage Page (Consumer)
0x0A, 0xB2, 0x00,  //   Usage (Record)

Thanks!
Chris

On Wed, Feb 24, 2021 at 8:33 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Chris,
>
> On Thu, Feb 25, 2021 at 04:00:32AM +0000, Chris Ye wrote:
> > Add "Share" button input capability and input event mapping for
> > Microsoft Xbox One controller.
> > Fixed Microsoft Xbox One controller share button not working under USB
> > connection.
> >
> > Signed-off-by: Chris Ye <lzye@google.com>
> > ---
> >  drivers/input/joystick/xpad.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> > index 9f0d07dcbf06..08c3e93ccb2f 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -368,6 +368,14 @@ static const signed short xpad360_btn[] = {  /* buttons for x360 controller */
> >       -1
> >  };
> >
> > +static const signed short xpad_xboxone_btn[] = {
> > +     /* buttons for xbox one controller */
> > +     BTN_TL, BTN_TR,         /* Button LB/RB */
> > +     BTN_MODE,               /* The big X button */
> > +     KEY_RECORD,             /* The share button */
>
> If I understand this correctly, not all Xbox One controllers have this
> new key. Is it possible to determine if it is present and only set
> capability for controllers that actually have it?
>
> Also, I am unsure if KEY_RECORD is the best keycode for this. It might,
> but does your controller supports bluetooth? What HID usage code does it
> send for this key?
>
> Thanks.
>
> --
> Dmitry
