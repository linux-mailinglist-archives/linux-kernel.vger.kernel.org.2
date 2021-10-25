Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD928439298
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhJYJlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhJYJlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:41:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC418C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:38:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so8377082wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=j2/0T+iSdDtcRBJSHhWbXXR9G0R0VHtIn5iZtNGvdpY=;
        b=O8IHmCxEqS6oDsG6t3xo1/CJc/mKQKQrKBE5I0MDKkQGd03S7OqsFskcTN/dsmOWNR
         zTybvOnp12d3zvtbq0kzMNc80oUxNQlH6SiLR4G4PUQe+9fyKLHiE+QjHnxB2LT1uDZM
         aMeiJaIIwsjLS1pRgtWUeFfZOyZGA2P7T6lx3YFlIVWFCaA4gbSZHwYulHYFELdB+YPU
         4ZhqrdqRwXram+3kTOs+Pctv8HtyIeM3xcbOkEwZjL9FA7AwVhobHrMR0pSwObfT990U
         qQQKhYLDr6/gONsRQZcKMb3gGBND4mxKesrP2atjQclfE/kHB7OtEb4gQ6YYl6JBUk2z
         CHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=j2/0T+iSdDtcRBJSHhWbXXR9G0R0VHtIn5iZtNGvdpY=;
        b=06uhEvC6ASIyMRSAVbEibIDUh2j9dAhmwkZZJ401Fhl9CNmA2FHS/69fqTWSA13AAq
         SThxPVFJB3smmSNVkPQievcmTgLdsSju5SRToGwncwA8+VcDfm2gNiET8CCYpKkjhwbx
         dEkCgGrNu4IYja7KrcfyCiWjKu0j7mGA9J0EXsRtMK9SzuO0PgDr0g+b827erVwSwc3+
         Aga3BboefBHkBkCTl8jog1Afus60cFvz+8AK7DpMS/70V3pcZzA2fM1bGlRJkfFA3ADA
         ky/hVuL/G9Le/NxTNe+xpqnZxv4QJg0a1kULkcYImbgPTc2Tiw41fH5jbkwICeMzCek+
         TLyA==
X-Gm-Message-State: AOAM532/FtSWaJXYadbQ1kTpVKSRtkleKIyLENUj139cjaminWyAJu32
        yEKbw7UnxVxK+SM9+5EaVjH8JQLN0ioAEA==
X-Google-Smtp-Source: ABdhPJyT9OntxpUvacaEwsTC1z3GP1l6mwKWW3rKtPLofWcuMSnvX3hOCI66pnpi/WPjiHdyhtVY+Q==
X-Received: by 2002:adf:8bce:: with SMTP id w14mr7800346wra.391.1635154732530;
        Mon, 25 Oct 2021 02:38:52 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l20sm21094729wmq.42.2021.10.25.02.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 02:38:51 -0700 (PDT)
Message-ID: <4a0993774f75323c803f7b07ff9825d7beb6d95b.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 2/5] staging: vt6655: Rename
 `byInitCount` variable
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Oct 2021 10:38:46 +0100
In-Reply-To: <20211022164011.GB464908@alison-desk>
References: <cover.1634826774.git.karolinadrobnik@gmail.com>
         <53430b1183324f6a715999792a15df2ea6a3e206.1634826774.git.karolinadrobnik@gmail.com>
         <20211022164011.GB464908@alison-desk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alison,

On Fri, 2021-10-22 at 09:40 -0700, Alison Schofield wrote:
> On Fri, Oct 22, 2021 at 10:37:15AM +0100, Karolina Drobnik wrote:
> > Drop Hungarian notation in `byInitCount` variable in
> > `RFvWriteWakeProgSyn` function. Change it to use snake case.
> > 
> > Fix issue detected by checkpatch.pl:
> >   CHECK: Avoid CamelCase: <byInitCount>
> 
> Hi Karolina,
> 
> This comment is for all the patches.
> 
> Commit msg:
> We've got plenty of space on that line, how about:
> "Rename byInitCount init_count"
> 
> (I say this because when someone searches by the oneliners it's
> nice to give as many keywords as possible - within the line limit)

Ok, will do my best to include it in my upcoming patchset.

> Commit log:
> The log (why this patch is important) seems to be saying that
> snake case is the fix for Hungarian notation. I don't think that
> is completely true. Snake case avoids the camel case of Hungarian
> notation, but we are also dropping the type descriptor which is
> another signature of Hungarian notation.
> 
> Perhaps this would be more direct:
> 
> To align with the kernel coding style, remove the type from
> the variable name and do not use CamelCase.

Ok, I'll use this format from now on.


Thanks,
Karolina

