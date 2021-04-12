Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6E35C476
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhDLKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbhDLKys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:54:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21F4C061574;
        Mon, 12 Apr 2021 03:54:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p16so2196849plf.12;
        Mon, 12 Apr 2021 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vilFxhUb0+fJEQ/bexM0f2QpCiANSDnsZGZs3eqyMYM=;
        b=lF28eNL9V4iMj5dHWeAx+9PsmNCjvV3aqUw/RLQRsMbLw/Pg+k59KNP8GaGcjeyVbG
         FqvyG1UfZxfjzIY+oxw5QvylWHRtJXiWaeynTK5dxkCkwnyF02EVnrRDNISr/MZ27HTf
         6N+eJNVfHuPn8kBsvqf+bGnEz38HG/fLfYJ6xUMGo4zponPdd5HWIymlTYNKFPJl1fMb
         JbWUHguCoIlMTVs7b+woOaZ4fOnjG7qFVwsD5VQZB3lIQ3yUp66xrQNQw/vqADAZVl1V
         UJ68269RLz4HrqFyEgvePr3VFHL7pwqS1At7kkFDdUyZ37IITGefXFPq7B6LXwdwrjyS
         hdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vilFxhUb0+fJEQ/bexM0f2QpCiANSDnsZGZs3eqyMYM=;
        b=ESBdY7FENMGXih8FdJdPrMear7eLRs/A1id4becz3RfVZmL4r3vK9/E6ELkGTLnNH+
         qWBKhyfUcqqdJXZ7RnsCwCHkvqz7mAxEcYheLJ+OtF2CydSBNzhdrcTNetTnHy8ZFleC
         XsF6qr7pbDoiIB661b1l1prhTIwbcb1/+RGlHRLGQOos9PRR5eidS2j/oPTpamgysmk1
         LjAbkp12L4aVJv/qB8OlAGJz3mphzFJAASx9SQC/WAVdzRO4hCkvkExqbiYfzcybIxvp
         F7QKReiGzzJvbJRXpgqM5eIuGmJUb2c3rYCd7jAII+SaasWq+A3up+bx55oNfVcuDmPR
         UXoQ==
X-Gm-Message-State: AOAM530GtocYFO2AGeZiAXaZnFsVTbSZ9yutfGxQuWWFRtq9DOazap5H
        +cz4nrUKGaQpf91YhKedCvVLh53gE3nwv05Uw4b0p8gZdWA=
X-Google-Smtp-Source: ABdhPJy8FZxzadh13/jUIN4JpLedliPzTgtCHeJOWgD4q/KKVnmabFXOEmU3gTX+PMo0vgzalj0xlHEmo9gL7J0g4rs=
X-Received: by 2002:a17:90b:1e0a:: with SMTP id pg10mr28773614pjb.129.1618224870426;
 Mon, 12 Apr 2021 03:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210412090430.167463-1-linux-kernel-dev@beckhoff.com>
 <CAHp75VfLQBDv-Bcj5=Ksv6kp2XH2v8msDvNjsdj6=WZiCk=Q9w@mail.gmail.com> <f406a5a6c6bfe0e458925821b6830e9dc5a151c1.camel@beckhoff.com>
In-Reply-To: <f406a5a6c6bfe0e458925821b6830e9dc5a151c1.camel@beckhoff.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Apr 2021 13:54:13 +0300
Message-ID: <CAHp75VcKYc4BWCM_8Zm7NONceAm2BbhTgDKOweu-qM9yLUHUJw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: pmc_atom: Match all Beckhoff Automation
 baytrail boards with critclk_systems DMI table
To:     linux-kernel-dev <linux-kernel-dev@beckhoff.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 1:39 PM linux-kernel-dev
<linux-kernel-dev@beckhoff.com> wrote:
> On Mo, 2021-04-12 at 12:43 +0300, Andy Shevchenko wrote:
> > On Mon, Apr 12, 2021 at 12:29 PM Steffen Dirkwinkel
> > <linux-kernel-dev@beckhoff.com> wrote:

...

> > I'm afraid it's a bit too much. Is there any guarantee all the boards
> > based on x86 will be Baytrail only?
> >
> Sorry, I guess I should make this clearer in the message.
> All boards with "CBxx63" are Baytrail.

Exactly! And this supports my idea that this shouldn't be done like in
this patch.
Are you guaranteeing that *all x86-based* boards produced by your
company will be Baytrail only?
Above tells that the answer is rather "no". So, I think we can't apply
this patch in its current form.

-- 
With Best Regards,
Andy Shevchenko
