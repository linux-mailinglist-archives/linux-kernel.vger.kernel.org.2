Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0068F311ABB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBFEM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhBFCzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:55:21 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF68C03327E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 18:30:42 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w14so5557943pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 18:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=3Fi8z3aDMK6SLGRFmW7/sd7tkTtOagycLE2d1dIDY6o=;
        b=rtRAOrV2nEwgcUNM8Bgzcw57M4vJGgkUG3PJgKWP1L/JR1szJU+EcKSvOLLf+aWKL0
         y7w4Ye1x61LIY1dsjUXHTMyjIN717p7guDykyWRE4n+4YFmRUX9XWf4q4JzjJJYBEwsB
         DrNOVtf1p4KRGkREu2b63Y7oZLer+yOdoGTnTVPH8lbhHk2YRh3SNavst23rynPd9gBz
         exFrm5GQ6JPEQBA0GnKvLd1T/VMjr8LlgZv5f8gRV/1mC1lsXNRUfEB2HEdR296toA88
         p5QBEeF0A1iTtuGF+17SQM1dQ4xhTjh7PbPCWM1HWWF8Px08J2w7PvOmLriJi8vzeOZg
         mDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=3Fi8z3aDMK6SLGRFmW7/sd7tkTtOagycLE2d1dIDY6o=;
        b=QglsAMFP6WdqaAXWv0Bh9frhf56n8WJwOe6QuCNliv6kJOBEsyc6+N/nvfHrpNiqp/
         T1+30sSBd45fludg4OA8R/HmHeZFkNlWLrhPFBvu/KprDg4e3GOeoOmy7/x0wDdD0+Zj
         EX88gJGT4rtLavrzZYb7AFdz29rv1BVWAxOax3/BKAAsIeNYcRpwMkaXJHBqYwWgSSDN
         TcSUR2pllMgat3epjBIpIbRrVXy6SVXvH7pNuSFLYacDZthyu4AORB11ZCqhOX7sjlV6
         xRUBwLY45nZlpJK9AP0DDeQOr+eyqIoANLxp2eqpHHg4Kpd5jY+YYrmjdpY3eq1jMHzq
         L6gg==
X-Gm-Message-State: AOAM532XL+PWJLHn3W6ssQpjV0Sq0yA4LR39piJljuOCUuNCJvom60YI
        1tVbC6fKU1apSBlPp+9jDN0tFrtU7kQ=
X-Google-Smtp-Source: ABdhPJzDGa3wDnCUkAanIdz0B9tGf5GQ/noqhwonPNUk2tdsE1R02jIiz7q+ZxsBl5i6u1W9CUjWtw==
X-Received: by 2002:a62:7650:0:b029:1bb:aa42:aa96 with SMTP id r77-20020a6276500000b02901bbaa42aa96mr7240915pfc.33.1612578641762;
        Fri, 05 Feb 2021 18:30:41 -0800 (PST)
Received: from localhost (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id z27sm6358444pff.124.2021.02.05.18.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 18:30:41 -0800 (PST)
Date:   Sat, 06 Feb 2021 12:30:35 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/8xx: Fix software emulation interrupt
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <ad782af87a222efc79cfb06079b0fd23d4224eaf.1612515180.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ad782af87a222efc79cfb06079b0fd23d4224eaf.1612515180.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612578497.zykn0q97ns.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 5, 2021 6:56 pm:
> For unimplemented instructions or unimplemented SPRs, the 8xx triggers
> a "Software Emulation Exception" (0x1000). That interrupt doesn't set
> reason bits in SRR1 as the "Program Check Exception" does.
>=20
> Go through emulation_assist_interrupt() to set REASON_ILLEGAL.
>=20
> Fixes: fbbcc3bb139e ("powerpc/8xx: Remove SoftwareEmulation()")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> I'm wondering whether it wouldn't be better to set REASON_ILLEGAL
> in the exception prolog and still call program_check_exception.
> And do the same in book3s/64 to avoid the nightmare of an
> INTERRUPT_HANDLER calling another INTERRUPT_HANDLER.

Hmm, I missed this. We just change program_check_exception to
a common function which is called by both.

Thanks,
Nick

