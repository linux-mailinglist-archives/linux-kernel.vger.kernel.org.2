Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7E4432DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhKBQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhKBQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:38:46 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4292C0432C6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:28:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g3so4736484ljm.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFG0W4zbuZBKc8KwN//b04i0rLIBd1L+XKZX7MrXoOc=;
        b=hpAI9rD1GQefjY1Adn77Zrw92FmMVgTkMn30tMZmiv+NzH79bDofjvVfqKAG8t/k/X
         RX50bQ0reQiJiASa+Wi3Ks1ITAO2X1a1eJlnJACu0G3dfCj6pzLhRwt8ttFnbVlWmoih
         YPvqmqixTXafViP0iPMRbo61wTri5tdAgB7Xgql0KMeJu4DRONJOd+Fi6ZlSTyat+I+Q
         5xy0YYH3X0UkObJm99RE+K2WL4jqLBDPTTC+Tzj6E00Dm9qb+8BNDCtMvoqEYLD0zh/b
         IqW8SERdtvpoDMuR6KEkDkzZ+qx8Wj5KfkegnFR8YN9De6j7NaUULuVOt67gpk6SN3hR
         u+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFG0W4zbuZBKc8KwN//b04i0rLIBd1L+XKZX7MrXoOc=;
        b=rNIaZuIT6gPzOkxUgLRgxBQJjdlSjxPr+wJOpQe2dBWz4Ye48MpEQOUC/jBKDcnUQK
         SFNwBU+aADVhswdFyb2NMOUeRPSulE5rBOa2jBIrEoLZR9w+In1rOMzON4nRT02RiM2z
         e18TieRm67iU1hvw6Ckn3G2PMAUGlKj5na++aybk2jyfFWTakrIvHuyXnhPOLo1h2opj
         FeqcJVibTLm4Cb4gb/ylCVE+XWlXjvXZA3jinkqHdh+xnhpt2CYwHKMHcuC+zuFa895a
         goNyxYdWq7y93mC/8wtA0ejMOnhzBmYFVy6SYECMG8usTcaRaHvYDFru9v8p6vj39G1M
         okeA==
X-Gm-Message-State: AOAM530yenIgw/VhVZImemH2msNRyAQ7MY5kHqMhWvs3xS6buzkzE7hu
        oYMJgH8Clk35rw/3nHKhrwR3W6im58TD3SKJfk/e1Q==
X-Google-Smtp-Source: ABdhPJyjGrPaYpq4OUOloYJA4hOuXnQyAusv+PW6kvERDc2Qqy0X3OdonYHzSsLN1pu41EWzSDjt6FFszoZuWuMvlVI=
X-Received: by 2002:a2e:9a18:: with SMTP id o24mr34636588lji.426.1635870514872;
 Tue, 02 Nov 2021 09:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com> <20211102142331.3753798-5-pgonda@google.com>
 <0701eb12-a60e-381f-ddd0-9ee9a0fa3edb@amd.com>
In-Reply-To: <0701eb12-a60e-381f-ddd0-9ee9a0fa3edb@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 2 Nov 2021 10:28:23 -0600
Message-ID: <CAMkAt6psP-qK3DJiDD=54_LKQ6cA8xHndD7wLmsOkrmvA=+EVA@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] crypto: ccp - Add SEV_INIT_EX support
To:     Tom Lendacky <Thomas.Lendacky@amd.com>
Cc:     David Rientjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 9:38 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 11/2/21 9:23 AM, Peter Gonda wrote:
> > From: David Rientjes <rientjes@google.com>
> >
> > +
> > +     nread = kernel_read(fp, sev_init_ex_nv_address, NV_LENGTH, NULL);
>
> Not sure if you missed the previous comment, but kernel_read can return an
> error, shouldn't it be checked and fail on error?

I did miss that comment. Updated to make sure nread == NV_LENGTH.
>
> Thanks,
> Tom
>
> > +     dev_dbg(psp_master->dev, "SEV: read %ld bytes from NV file\n", nread);
> > +     filp_close(fp, NULL);
> > +
> > +     return 0;
> > +}
> > +
