Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30F44E45F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhKLKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhKLKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:12:20 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD9C061767;
        Fri, 12 Nov 2021 02:09:29 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bu18so21179051lfb.0;
        Fri, 12 Nov 2021 02:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqIR++buI8RyiGgyz9WAHQDYgNxQlwmeSFN1EAOLh1U=;
        b=eZxbv9P6R2vXwmzKIy3MaUffmY0qCacsVdJULL+/9UqHI+LyYgZGGYnGw/ddKfeXMO
         TIdY9eF0f2lWwAk9T+lndivh6yTczJIKxdNZqD4YiWnaK1gKXtpDf3GdVAuShIXF0i1+
         7S+kG8MQ/kFXBMuj9GAdXI6c9r2RSS5Li5AMsCDhmfMbApSL3vOc12YJJGR6rh3JD9QC
         asbZTt0hNBNg/Mos9BSwTpfzAvfus9gOMjTyMVDdZ9cyMCvQlKPj/RS40uDRBYFD3zAY
         2NuJeZ1XVvf2oxftqLZSru0yWbOYyoDZR7SxfNVPlM/WkFcrMrg8hDBUKo35lwiSIjl/
         ab7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqIR++buI8RyiGgyz9WAHQDYgNxQlwmeSFN1EAOLh1U=;
        b=tk/WiXLrgAouiaoASnb1d4VtjgvGKODYJ91py/U7nSYT+2spSCmoSUo+JKWeaDfpP7
         fsrNoe45EzF5dxHKqzc0PQ2VW/VtnwPgixocvhH0YRnaNkFq2RwLduiYlI4r7hqVVjcN
         qWq86kkIq7s7Eu964W+oG8b//kQjVpIorOyqQs3rH85z/tTZcXSNKyNYraRrx3aAZXxf
         xbvDw67gT+0hmpyrA4P08uUeKDsJ1oKcqikqTnpNhWA7gnyQY3bXynbysWlVQ5tE6df5
         2cu9rpTo2MgBFNlipbNuiBZkXdQZ40jMC8U6ZJ+IRqiHM+YBkC4q39zSmSAYmqcd44yk
         bgdA==
X-Gm-Message-State: AOAM533vk3lk0OSm/JfotcFb45XS7LEWlIth1zsnyK5dxUIloyW1DOTO
        td+PUsjAPOdMHMRua94IT9IRpO+A1mCJIgaxxzY=
X-Google-Smtp-Source: ABdhPJyiMhsppXgPGfUYuVDwr8cAWSDpLvhwuhhIdiGub8kMYDecKGbvDExxWC5wvYjfJfYTbBnMmZ0yruNmaw6ZsG0=
X-Received: by 2002:ac2:5496:: with SMTP id t22mr13177632lfk.478.1636711767723;
 Fri, 12 Nov 2021 02:09:27 -0800 (PST)
MIME-Version: 1.0
References: <YYzxWPIWFAV04LRU@lahna> <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <CAHp75Vcp=hC1oL5FBQDDFe8EBxWB9Po4FKNS9ZGtD3q-yQPtAw@mail.gmail.com>
 <CAHifhD6p9qSm5dv1spz+oPRhRkBZeQspHNEphE49fODacm-S6g@mail.gmail.com>
 <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com>
 <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com>
 <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com>
 <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com>
 <CAHp75VckB0RA6zoLRQ2UOcQRgMEf6sNxDGfpsNVr+92eArhD=Q@mail.gmail.com>
 <CAD2FfiH9OcKyUo6xjTfSENrEKF=4kZiGU4rT0FriK6KgKYSzyw@mail.gmail.com> <YY4PHacrS4czhEx3@kroah.com>
In-Reply-To: <YY4PHacrS4czhEx3@kroah.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 12 Nov 2021 10:09:14 +0000
Message-ID: <CAD2FfiFTsj63NJTKjOhHU0FZ53uHCnG9SDdfqkj3cGcH=vos=A@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 at 06:52, Greg KH <gregkh@linuxfoundation.org> wrote:
> Why don't we just export these areas to userspace and let the decoding
> of them happen there?

Unless I'm missing something, the patch from Hans-Gert does just that:
exposing the IFD BIOS partition that encloses the various EFI file
volumes.

Richard.
