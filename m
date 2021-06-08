Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3D3A074E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhFHW6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFHW6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:58:04 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C35C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 15:56:11 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t40so10226027oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 15:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BMR6ZsMu0DsLETDw+bR4c+k3NXc63hDcJu3C1mBGeig=;
        b=po68QmPrwLQPdeWASh/uCRcM3A5us+ZPX7fX+qf88rjlsN//0fe2+T1vFAzNkPtH6h
         2Gsl2Wfp3SlCt8DaaGDAmN6tZim8fxtkWE+MyCetGq+OJ+3QnXSdKWnZ/x3CR2Jwa2A+
         436KSw3tINROsAZVe3TGTaSJQWdjAJt3H8LrGaIqi2smzQ4ORZchReX80km8gZeLM2KB
         dnAaCwbRZLGP3GZVr7NXnicHEo/EACn5qxtWzx0jEUJtE3XQtYKpAkGWgiFbYZWJ4wZo
         vJtANCGabveMWUHBVUNrJadG5xnmvis6m38TqUKkJWOvetfW3RHE3X8GXNZtI/D4jWhQ
         h6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BMR6ZsMu0DsLETDw+bR4c+k3NXc63hDcJu3C1mBGeig=;
        b=uHwZW8IFzWfkCZXkKXSJL1pZ3N8Zc840Qra2xUr2Ui3TU59uU95zLZJG8Q8ImZuQ//
         vEwOksjR5TRzrbvSoe5UmsadOabYW5U3BPrX0UUdm/Z8iYeit5vTI7ZJO4Yjtc6/huY1
         znEhPxELxS27FRRgLGoyrB3+CZFJq4jTOLpK5GcZSShh7T15WAkLk5FjNXI5Yq6Zv/Pk
         b1UI9IrhjZRllCZuFgdMejfRR0DVxN9ZBKxDuZTDKng4jTRnZgUiFwyXJEbbDaqvWUp/
         TShdZ7iKIkWRfyDiZ2ztIzkRVv1NBJ9pDvI+YAO+qDcdOhyJSTS+w25lxJRGD1VXLLQ2
         yA1w==
X-Gm-Message-State: AOAM530073Ul2tlsgSxCB7Z30DCS6WcoLb6BXY34Ii9JZqtssifgOOfs
        UoonYp2rDuA8SBfhBd1A0Ayw52PFYqQ=
X-Google-Smtp-Source: ABdhPJwL//nNXkoUzcYy6m2sK3nXMN89+1pNo/7vZauwBDKfg/qlPYB+3VuW0YMQqAQBzUKQc1ODtA==
X-Received: by 2002:aca:3e89:: with SMTP id l131mr2143381oia.34.1623192970886;
        Tue, 08 Jun 2021 15:56:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i4sm3341516oth.38.2021.06.08.15.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:56:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 8 Jun 2021 15:56:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.13-rc5
Message-ID: <20210608225608.GA1244211@roeck-us.net>
References: <CAHk-=wgxOqRbXUwQ73sMgxfOg9+B7BeTgZ6JP9oHR9BPhKGjOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgxOqRbXUwQ73sMgxfOg9+B7BeTgZ6JP9oHR9BPhKGjOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 04:06:50PM -0700, Linus Torvalds wrote:
> Hmm. Things haven't really started to calm down very much yet, but rc5
> seems to be fairly average in size. I'm hoping things will start
> shrinking now.
> 
> Networking (both drivers and core networking code) is once again
> responsible for a fairly big chunk of the fixes in rc5, but there's
> certainly a fair number of fixes elsewhere to - architectures (arm64
> has mostly devicetree updates, but we've got fixes to x86, mips,
> powerpc in there too), other drivers (GPU driver fixes stand out, but
> there's also sound, HID, scsi, nvme.. you name it).
> 
> And we have a scattering of fixes elsewhere too: filesystems (btrfs,
> ext4, gfs2, ocfs, fanotify), soem core vm fixes, and some selftest and
> perf tool updates.
> 
> Most of the discussion I've seen is already about future things, but
> please do give this a whirl and make sure that 5.13 is stable and
> good.
> 

Nothing to report from my side:

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 462 pass: 462 fail: 0

Guenter
