Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58190459B67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhKWFRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhKWFRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:17:38 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B56C061574;
        Mon, 22 Nov 2021 21:14:30 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n26so18258228pff.3;
        Mon, 22 Nov 2021 21:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LTrEwlV4tO0CKDuPJnxs0wjii8wYlBP1Dzck83uF+lE=;
        b=e/ZGpxUY/7geZY95TewDu55eM9+/gM/Rl/9uelqyBdB0oXYucfo+GnLE6T5IcCtLeZ
         dwlwejCmU7LYtdGnaipXPdQhW9jjh6rnuUQqf+0229JY4LIglZxcnOZ/n77TjEytGfk9
         TaANMFJm55OlAbbwCfQU7AU7oc6VHfSAHM49YtAwGfr4hE8edFvNLUjnE/paYz94vceq
         Dw7XnIqpLRrU+oeMu5mdnhO06z4iVhUf3CGkgvDpkgvwf8CFE9r8U5JIK9DLZgZeaDVL
         PFaeJt4Roxlxq0/W/cKZHYK4k1LhHnjmiV9e3Op0bYd8Q2iYR21p7g4/nTEV+0qmE6Pv
         43ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LTrEwlV4tO0CKDuPJnxs0wjii8wYlBP1Dzck83uF+lE=;
        b=dtx+kgV+tDz/nXDP5U9jHtws6de2LlWMbjXSsSv3vlwKDd92DDgjXU2nH8kafn+4ft
         N7UE2HudVw+dSixC2ivyEexPd3Oa1hqO7cW79tFLC+qz4IbuY2tIq3OwzzqNx8uZF0o5
         zmTTiosI9vwmfagZeRAwC/Zd3ZpZ95v8d8XEbVGmL4zr/asywY9jWKJv4ccl3n99ylxs
         ww6TKXv1mlNCSU7an6rxS27q+rNz76GXWKmZtkG8leCYuweNp106wLLRLM2HNnbaxcZk
         Ibk5NzK/chCB5EuyTAZXUs+ZYs9nTuZ2LoIn4MlgAzXNSpACd8xN4mrLKYdIPfScfRhd
         OmQQ==
X-Gm-Message-State: AOAM531B/VY+NxNI9W+PcOGyQTkmIQVlvLtfAeeYX9xdogCEH3QsQxEu
        kiyfvI2u9XH1/IVSmI6F4mrwa+gbD5kjDiP+zJA0R5OlU/oO0w==
X-Google-Smtp-Source: ABdhPJwPa/oQ1LunR+h1in0HvjPxTo85GkcSZ6PvtKN+g8QYZqj8y/O5tbCdoy5RrWXbfEzYKifjheH3IqKs35dVmOI=
X-Received: by 2002:a05:6a00:1312:b0:4a4:e341:213a with SMTP id
 j18-20020a056a00131200b004a4e341213amr2294078pfu.57.1637644470038; Mon, 22
 Nov 2021 21:14:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+h2OgBMP8Mm+dNPuNEq=DhWdc7Y+dJEvrXz9kAUD7O2GQ@mail.gmail.com>
In-Reply-To: <CAHhAz+h2OgBMP8Mm+dNPuNEq=DhWdc7Y+dJEvrXz9kAUD7O2GQ@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 23 Nov 2021 00:13:20 -0500
Message-ID: <CAH8yC8nEhcAs5hE=utcUEKZ8kohOx2TWhUsbue1sdZo23uiBHw@mail.gmail.com>
Subject: Re: x86, nmi: IOCK error
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-x86_64@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:03 PM Muni Sekhar <munisekharrms@gmail.com> wrote:
>
> The following message is seen on the console "NMI: IOCK error (debug
> interrupt?) for reason 60 on CPU 0.", what does it mean?

Red Hat has a good article on the subject at
https://access.redhat.com/solutions/42261.

Jeff
