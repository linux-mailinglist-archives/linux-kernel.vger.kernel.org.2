Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CDA42CEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJMWvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhJMWvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:51:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A5C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:49:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om14so3355238pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzcJqcZKaeP4N0r2R1aUwTSZHSBWK2JQNN59igSj9bg=;
        b=vPZXcUwuf1K265GJj8iIKKtmClnf1X3/ENDU22ChBpToG9/0UNfVWmUYKdU7mZHsiu
         o5qGCbisyw1McngOT+uM7pSOONaLaVwqFpTU0kw30+8GAbq+iM7slO3wJFXIDFjMRpMs
         3Vky0ze1Q2VS2L5MTCawll1tVB1yanrB/dZX7QIgzIdSAEMi4HPV3jWJPszNSDrqTN4c
         bm1T4QmKF5lMiJHbXPsTvJxcSq+DhHbBwnnah+ozSRBsOboGfVzOBqAz57EbTlV9Dm9U
         3d3PWtODSS5XXncAUgxzpAo1QF1rhDlYGlJTaKbR9JX0YiEa8m6BCFHWj9aIxbHmvl/D
         79kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzcJqcZKaeP4N0r2R1aUwTSZHSBWK2JQNN59igSj9bg=;
        b=fl28EdDULrrbtA4o09p0Q2w2LYt4q0SYEGRMCkLcfJ1Uy8nW7EffOlXr8mQQX+0ifC
         fYMEz5+TjrtipsJMVzrNuxbS5UM+kgvKwJxSE+XnwrPhDoG0azoht6nccVuSwxXhmAXN
         k1S2csoA1oJuyXupCXf4gWvYHi/CVT5wZrY7F7CRYZiOAo5+h22Kor4VXCAWPsTYI+yo
         SJ7zjPIWCnRrycVcIk9+mXbg2HJ/Fw1vtPp0SpDDmrSileQ7oIFW87INxClwZbax/dKB
         1fBMBJAs5mjwvH/R93eab6TALJqhp8RqUlcfbaFyBBm8xktJswueegQk11DT2W71tlGK
         5ezg==
X-Gm-Message-State: AOAM532LaX+RH7RkbgquRcjfv4rrqWoJXunLZazRtHEeIiHhfQaUjE+b
        Oa8EFPKNH+KJXyoiGMr82Ts1EIkRIq5kQor23XQsumOPKyI=
X-Google-Smtp-Source: ABdhPJww2lQN3rWRGSl0Xrohz3SxU98D1oyYuUtwtyaSQEfPit3AjHQnFldz1HLlCTkUoxm+2IrROcbWMyTUwh6Oopk=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr2317067pjb.220.1634165381427;
 Wed, 13 Oct 2021 15:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211013224523.rxyt2mg75ebxismi@intel.com>
In-Reply-To: <20211013224523.rxyt2mg75ebxismi@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Oct 2021 15:49:30 -0700
Message-ID: <CAPcyv4jHxWJQSgGFg4e5tSg8dgDcYVKrzXEN8gtg7TjNRj3h0g@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] cxl/pci: Split cxl_pci_setup_regs()
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 3:45 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-09 09:44:34, Dan Williams wrote:
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > In preparation for moving parts of register mapping to cxl_core, split
> > cxl_pci_setup_regs() into a helper that finds register blocks,
> > (cxl_find_regblock()), and a generic wrapper that probes the precise
> > register sets within a block (cxl_setup_regs()).
> >
> > Move the actual mapping (cxl_map_regs()) of the only register-set that
> > cxl_pci cares about (memory device registers) up a level from the former
> > cxl_pci_setup_regs() into cxl_pci_probe().
> >
> > With this change the unused component registers are no longer mapped,
> > but the helpers are primed to move into the core.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > [djbw: rebase on the cxl_register_map refactor]
> > [djbw: drop cxl_map_regs() for component registers]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> [snip]
>
> Did you mean to also drop the component register handling in cxl_probe_regs()
> and cxl_map_regs()?

No, because that has a soon to be added user, right?
