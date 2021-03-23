Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA47345D48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWLr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhCWLrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:47:22 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D038C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:47:22 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x9so14624518qto.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F419BnJhxixFSvZMAKXs4tvDppivStl9M/Uz5fVRylI=;
        b=Wy1rSrxIYeID7CuQYaMS0MZRvHoWezSWSA2aD+o8OrBl8/dVc6qlnLFUuRe+cIiWVt
         lCwdLHNDmrodLM92ArNQMJP9p+EhZSMga5iNEhfXsMUM0LYG1drnVmbUt7ZH/qDHVyRT
         9uh8/1gAsQSryCHTjufM8BCuLbB8XjfhmVwG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F419BnJhxixFSvZMAKXs4tvDppivStl9M/Uz5fVRylI=;
        b=qNhmwF953hwfa5VnqX4aMoyDT9LiQibfdMqxhbYCMR+puKut83+sIWe/SYLdS6bJFc
         dQjy1T7d/XaUoXDkbG4Y7xLH72vZeyd7t44A20ymNUhYJ3ZMae/YUf0QMAHxZFBBKABg
         HyhLvMZig6Ofe21okFSDq2Bki5yDn3z9U5ETYGNbw7BB3t+zryrgmxeL5xVPYxOB+Cfr
         oRTHT/dX7rgNs7Z4lz8m4ncbeeyW2M7YF1G9qBckLWl1mQ8zPLtaekBlISR4BikKi3jc
         Fam/rSlU2jPgmGWZjhRFdoXOmI6PRZTdk22JmuCFsz8F0eMneL8yIkPihSLx+hr9A/ym
         LSNA==
X-Gm-Message-State: AOAM531Gkw+ewxBAVwFinKbQuBeR61K+zO8TfF5WatFqPq07yxM46bT6
        Q1KJ9RJb8e6JXbsM5OI4i/Ll6W06I+MHNtPsx0B3q/jmHBQKBQ==
X-Google-Smtp-Source: ABdhPJxb4rk2yYkFLAj4LkiXAJ0uAXqAM0jCN+3GxM5jbVeWvshwoR4hcoZ9d+U2rKSvsZlRIakjbREIeEeJIVUVbJM=
X-Received: by 2002:ac8:7f53:: with SMTP id g19mr3907305qtk.249.1616500041105;
 Tue, 23 Mar 2021 04:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210213095724.3411058-1-daniel@0x0f.com> <20210215112409.1a755bf0@xps13>
 <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
 <20210215121653.4edd86c4@xps13> <CAFr9PXmVehtcm6FjBqi_hmEAj1rgtxMvarisjPmWhgjruVj++Q@mail.gmail.com>
 <20210322193213.18520b9a@xps13> <CAFr9PX=mL9UWcr-yWbYa5NXS-R=yHeGgM+hd_MKOa2XiBUAJOQ@mail.gmail.com>
 <20210323113233.3523d66b@xps13>
In-Reply-To: <20210323113233.3523d66b@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 23 Mar 2021 20:47:10 +0900
Message-ID: <CAFr9PX=KMZuzp61Hq=2WdHyEzE=6J7HEPWZxPs7FEqiH-G8wFw@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Tue, 23 Mar 2021 at 19:32, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> You can run nandbiterrs -i /dev/mtdX
>
> You'll see if there is ECC correction or not (and its level).

These are results I get for both of the nandbiterrs tests.

# nandbiterrs -i /dev/mtd1
incremental biterrors test
Successfully corrected 0 bit errors per subpage
Inserted biterror @ 0/5
Read reported 4 corrected bit errors
ECC failure, invalid data despite read success

# nandbiterrs -o /dev/mtd1
overwrite biterrors test
Read reported 4 corrected bit errors
Failed to recover 1 bitflips
Bit error histogram (883 operations total):
Page reads with   0 corrected bit errors: 845
Page reads with   1 corrected bit errors: 0
Page reads with   2 corrected bit errors: 0
Page reads with   3 corrected bit errors: 0

I guess this means ECC is there and it's working.

Thanks,

Daniel
