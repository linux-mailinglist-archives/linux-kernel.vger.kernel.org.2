Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD030A62F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhBALHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233524AbhBALG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:06:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3778964E2C;
        Mon,  1 Feb 2021 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612177576;
        bh=uI72NpzzrWRkbU0c3KrjWhstn+4P0H8+M35W3nbhojQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j2gHrbgu+itZBUqYNCPL1l6h6Uq5mFBwQvpxw7NlVl1hXp0AHBmxY5q3E+khzWwu6
         Ya8uPzOLTOjGAfWKzbIvf26k9tjATDomc97ek5JCehlbARDDzrYd9aiJCZOlxZjgAL
         NoMOAuMoD1aipLyL0WBucagFapnt2z4Np7rvmlFhFYg1dQ41BsrOJ3t3aRU5tTkaA8
         +GUIwVRhYIcJmCsnXINGmQ7I5kbtv/fAgi7+RYrblSNLhc7AFu+X3iiA2+ZJSV8fb8
         XegLlolvyNgza8VunvjerCcIlhEaWPmCWuXMnsBeszXUatYA4/Ys9ePkvqOj67zgbf
         OrYDqqtTf7DkQ==
Received: by mail-oi1-f170.google.com with SMTP id d18so18378055oic.3;
        Mon, 01 Feb 2021 03:06:16 -0800 (PST)
X-Gm-Message-State: AOAM531al/xqZRUCuu/nzhvSN5t23MlHnDuq9w9r3i26PqXtfA4QJztA
        1B4fMaTjDwS/aaI5g/5+R8ws67/inhtac3vge9g=
X-Google-Smtp-Source: ABdhPJxeiBL+ktiVETssUC13apk5WtBacq2VYLqAaLKcSi8Ll+PcxRm1UL/L1xDAMaP+41uLYhqffl7hnXlNH+aCrGk=
X-Received: by 2002:aca:d908:: with SMTP id q8mr9992933oig.67.1612177575431;
 Mon, 01 Feb 2021 03:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20210128180239.548512-1-lee.jones@linaro.org> <20210128180239.548512-2-lee.jones@linaro.org>
 <20210128181903.GA2099675@infradead.org> <20210128182713.GM4774@dell>
In-Reply-To: <20210128182713.GM4774@dell>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 1 Feb 2021 12:05:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3XgqD_bDreG_SPCfrjqLaduEpiwiWFVf73eNkrrMoBtw@mail.gmail.com>
Message-ID: <CAK8P3a3XgqD_bDreG_SPCfrjqLaduEpiwiWFVf73eNkrrMoBtw@mail.gmail.com>
Subject: Re: [PATCH 01/20] ata: ahci_dm816: Ignore -Woverride-init
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        IDE-ML <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 7:32 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 28 Jan 2021, Christoph Hellwig wrote:
>
> > On Thu, Jan 28, 2021 at 06:02:20PM +0000, Lee Jones wrote:
> > > Some ATA drivers use the SCSI host template, a series of interwoven
> > > macros, to aid with initialisation.  Some of these macros conflict,
> > > resulting in the over-writing of previously set values.
> >
> > Please just disable this warning globally.  This is a sensible
> > patter and we should not sprinkle per-file options for something
> > that fundamental.
>
> Will do.  Just as soon as I've figured out how. :)

I have a local patch series doing it like this

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5f550eb27f81..4e4cc14a289e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1390,6 +1390,8 @@ extern struct device_attribute *ata_common_sdev_attrs[];
  * edge driver's module reference, otherwise the driver can be unloaded
  * even if the scsi_device is being accessed.
  */
+__diag_ignore(GCC, 8, "-Woverride-init", "intentional override")
+__diag_ignore(CLANG, 9, "-Winitializer-overrides", "intentional override")
 #define __ATA_BASE_SHT(drv_name)                               \
        .module                 = THIS_MODULE,                  \
        .name                   = drv_name,                     \

I think this also requires a preparation patch to extend __diag_ignore to
additional compiler versions, not sure if that was already merged.

         Arnd
