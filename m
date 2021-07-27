Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE413D764E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbhG0N0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbhG0NZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:25:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:25:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i10so12657375pla.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sj4gJifOrkoU7DlVhCp3UPFxcARtLuS9gmjuHOue86Y=;
        b=HAS/GrGXG8YGN51qv56OFvXHWpZ5qSPcXAR8IBDBZDCKCVuNzhA5r/E/HDm6phKrNf
         uXG/tGwPAp70UueB76jpYhWu5grbQFG1p7MXwp4cRSvoAAdvwKQSQyvZjCzZ0pewkM+6
         7D5t+CggV0rrbN5UlCk1RMdIj6LIxSvOyZ+pCsIuqwFLvDS35DfqJzbBDD6ook9maEKR
         th8XTWo3pa4vpLrYE6wSLpTszkN0cL16ESwhSthFn8nAqftvOqMQnmy+LXmpSmCyTe8G
         DaK9OypY38rNo+9ioV0we98b9HIHUhlhmmhI/gVtIFV1USaLm0ZYrKaF0PewlDMMAw3R
         yFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sj4gJifOrkoU7DlVhCp3UPFxcARtLuS9gmjuHOue86Y=;
        b=QuYTHrrO2lLaWwLH48OvLUK9KDUOpXOoToRkq4kwB5Tl4WaGnji1EfL8Os3rztOSYn
         Mpnn3uSSzICgQLc+tnhnxEu1GUfpea0QNU/EfCSJ/E9fwPu0SuwmpOPl+uk2RbbDe4Ow
         tb6iVCqFAdg9V8u59JISaKN93TJDvryTZeMoV1hMMcbc+8CY8IlJyt+eAiVn4k7xfzyl
         auJe/cPVXT2q94VXqCqeGD2XIEa1cendBzzq7fr8yaXmJHKtPoGrqpQm3p7FQsMd4WIp
         nGFXUX67MGB5IrKBAGJM7OfAQCsdUW4OZU0w7NMIojgAQpl8HvUmbZCmLyvVEwV9Ha6N
         rPlg==
X-Gm-Message-State: AOAM533P0V+TPUKX8twi3gD6AVgGiXLiUvroTWyIgDXVLHyDZlVdcPd8
        gK4eWmaFYe8tfZ3IDslTjzRNzklDL27uHG84oT1/kQ==
X-Google-Smtp-Source: ABdhPJxL31vUFNVWIYkybbAcA7zXMuTQU1STyLSzbL123qPq4ghFjZHP2LBaD+BBmR1Qie1oflrkXeMv9QhUWIHPAJc=
X-Received: by 2002:a65:6181:: with SMTP id c1mr204980pgv.208.1627392345677;
 Tue, 27 Jul 2021 06:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210724001055.1613840-1-phil@philpotter.co.uk> <YQAE1q9ZWRPHqfK5@kroah.com>
In-Reply-To: <YQAE1q9ZWRPHqfK5@kroah.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 27 Jul 2021 14:25:34 +0100
Message-ID: <CAA=Fs0nwOBUoCSbwzaE7TTQab_BZcCy2SL1RJby+Hmo=URw_Pg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] staging: rtl8188eu: replace driver with better version
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 at 14:06, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 24, 2021 at 01:10:48AM +0100, Phillip Potter wrote:
> > I had to break this patchset up a bit to get around the file size limits
> > on the mailing list, and also I removed the hostapd stuff which is
> > userspace related and therefore not required.
> >
> > The driver currently in staging is older and less functional than the
> > version on Larry Finger's GitHub account, based upon v4.1.4_6773.20130222.
> > This series of patches therefore:
> >
> > (1) Removes the current driver from staging.
> > (2) Imports the GitHub version mentioned above in its place.
>
> Let's do (2) first before worrying about (1), given that we can't get a
> version of (2) that actually builds yet :)
>
> thanks,
>
> greg k-h

Dear Greg,

I'm confused - v3 patchset builds fine for me after applying in
sequence from 1 to 7?

Regards,
Phil
