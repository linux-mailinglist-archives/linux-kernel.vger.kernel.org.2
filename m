Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38B837F1DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 06:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhEMEKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 00:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhEMEKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 00:10:44 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0F3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 21:09:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id v13so22027170ilj.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 21:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/6iQ9feUmQbqLpcXNhjAtW68qMrYe+jOzmvcWEoR5s=;
        b=fnTE+3D2noQLaS+tmY8b0zbu9h566HqyRwtOi3ypcZwDakflv3ddkNLgBn7Ueml5S7
         wa1tuBhumHLLtkgFJV1+P9AZ/VJbc23VHsOGfGHE13U7ENVWouIqSctb17FnQdN8+B1o
         MgoRiXP3r5s4kI2EJrq/vnBML2DtaUfrY/HRCkN6dKzHup5RoKUYjSQBV31gL+iWdV9e
         xvYrMi9kuDBSJRbCjJl2Oc93rPkeaHXxY7gxxznMlq1XFwD1BT2aUTIgH6fIodLmywpa
         PTb79/t3A14rwU+1LBwaiZvi0NNJKNfr6AckUSzIzi8jI72QPrjJTBUwQ7B8q0h6e2D6
         UGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/6iQ9feUmQbqLpcXNhjAtW68qMrYe+jOzmvcWEoR5s=;
        b=PAp31EQwOIcXYSiBsDB2WP6Jvys6MG/nx5LpQ2bSMHp8NNUajG3aICkvvQbz2IKxj+
         Ybc4BvcIwhcBu7/T97T0kl1kFmB9BDZ1RBYG2UF7s4XvlR0oNPF8qIhQuD8rKfyjkpko
         HfdHJBQn06YfT51IHsUDhwM+8EI3rprskIY5k1DFtLB/geCDbxYI92KnPqdhmSXGBSSg
         drLO8K1cYi0el4GLFMKx+4dIDj0cATe3hjkS3Kz6ppelnAeG+LS1mkVCMDwC4G12/kxT
         B2GtsRqtUL2lqzPQyrxThhx3mMwuOsnT8rbfDhy5y+l6YwcfwnmInizSdD48Apk3OUt/
         qgGQ==
X-Gm-Message-State: AOAM532n7Toz8F+OnlqzojJlozLjf8Y4rw79W+S852ilBZT8it8uNwjK
        J4106HXodAQ1bJzsTryxk6HdiLPBDnOcnd3vDvo+G1RSW/PzlQ==
X-Google-Smtp-Source: ABdhPJzy5X6XMObM7pKfa1lYSjeqZf6P4BaGclob8gZi2MWjiYoxhfFplFptsYQBzndwVILYXIRcbTySdkarVMv5zgI=
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr34748298ilq.81.1620878974686;
 Wed, 12 May 2021 21:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <YJrFib6BD8JcX3DM@kroah.com> <20210511212937.1269191-1-ztong0001@gmail.com>
 <YJt0nI8lG+2juL5S@kroah.com> <CAA5qM4A2-RD-cnJrGrsAcRixU0nfX7xFWDkxevDoC4TsBbkh9w@mail.gmail.com>
 <YJwFLgvgIXHn8Zch@kroah.com>
In-Reply-To: <YJwFLgvgIXHn8Zch@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 12 May 2021 21:09:24 -0700
Message-ID: <CAA5qM4AsYP1CzFh1hLyjpYo=sSabbRat2=r-bfJeWbAY3QKduQ@mail.gmail.com>
Subject: Re: [PATCH v2] misc: alcor_pci: fix null-ptr-deref when there is no
 PCI bridge
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 9:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Can you document that better and add a comment here, and properly handle
> the whitespace and resubmit?
>
> thanks,
>
> greg k-h


Thanks Greg, revised as suggested and sent as v3.
- Tong
