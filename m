Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644DF348774
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 04:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhCYDWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 23:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhCYDVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 23:21:47 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D59C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 20:21:46 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so652142otr.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 20:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LhekbqtuOQcfnVYM+NJjvLu7V0qQ67rxH10e15NhwU=;
        b=D8FXZDPcOdvkffEjYsCLmwlu5glW+BEuFYiGaC3gUvLryjkAsjHRZ69IYCpmBI5hBi
         gUbZMtTcuAnjZv8QY77mUAMEIFD4wLCmNsZ7rPXFnTZYBBPrihXWcmF1D4b/ef7ER1y1
         xUsixWI+MxDbixZ9JRO3I0ZEs5ArqAt9ujLF63lHEQv2CnPqxXo7mUJc+90RS+LBVyMi
         ed5UJH4OhHFA9HwORZ+/ymKbz/gj6kI/PNN6qfBTgQAuiOlkjtAm5AMdAyi4VvQ8mHHM
         z7cTI2cjp2Q0SHbrANCk1w7F09KhRe6QXMapAm3kMzQvJahwemJWTEVHfT0AK5AjNnFA
         y/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LhekbqtuOQcfnVYM+NJjvLu7V0qQ67rxH10e15NhwU=;
        b=iWz4n3CxOzdF+dGqBFTa2FiTx0VraplDyG/R0iWSFHTdjxiDlykctuMdXnAOQylJGx
         /o8rgHtNk7zWaKJsUkUGaEqdkFLoB06Bupn9pPl2jYWQIVQWCo0tOcvzzcgwj7vqUZ9h
         ofHXL2qjJzuoznN7FQh/BHYDAo9VBmNJEY9/cQ0UEnqv2dvJX1RDPt/8J3GOziwZ/+Y7
         mNNZ7YFNv3W+Wx3UXiQf/LXgaC4tZ8Du4sgbxBxO0q6Rf5JgqovvR2VmORahXMM2uigb
         pIgt9E5ZnVj+P3Acv/x51IP1adFk/eGTsDCNl+74mnsOaJigJnIB5+eFCDN6zjP2ywZ4
         Px7Q==
X-Gm-Message-State: AOAM533z3K9gZ6X1d3Jrusvf9tPjPCx+DegDOr6GktkeDv8S/cVIYXN9
        wrqU3/A/P0uWw+EyuIjBEPOBd11PDtol18ETdYPlfg==
X-Google-Smtp-Source: ABdhPJxTgql0rnGsMW0v8subIn7KHnS5/dyuNMyqc1AF0dE5WKZizvZf4u+nCF+96sl4XogDLPJEp2g3p79JZoDdKc4=
X-Received: by 2002:a9d:6249:: with SMTP id i9mr5760502otk.166.1616642505612;
 Wed, 24 Mar 2021 20:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
 <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
 <87lfaj7cki.fsf@igel.home> <871rc4on36.fsf@igel.home>
In-Reply-To: <871rc4on36.fsf@igel.home>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 25 Mar 2021 11:21:35 +0800
Message-ID: <CANXhq0pDge0BPgAjoLrX7Y2qtofb3dhV1_CPHBaCg0o4cEMrbQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 6:36 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> Were you able to reproduce the problem?
>

Hi Andreas,

Sorry, I'm not available past few days, I'm just coming back, I would
take a look at this again. Could you also let me know which bootloader
you used (FSBL or U-boot-SPL)? Thanks.

> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
