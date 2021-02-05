Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA413107DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhBEJ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBEJZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:25:52 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50868C0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:25:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 8so3241146plc.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s43rqcddTJ2FeEIu7EODes4JBPptootjcXSiKSYA+pM=;
        b=nKGabKVcenfJ68yBGA4Cc1EN4/QAYBP1kedi7EXt1QRkZDCnBMYkya7hIRNrT8vu4y
         6z2Tk4LrWTYqOQ1StYLP0NWwJDlx85r+FMLu7oLT5AqrmYIzrl16EolcnA6/wBM3qc19
         4EUXCz22M7XJeLIgUgJvDoZc/jMrm49M5u3YYQskhWxBegoWFG0cZiYyEjxmMbhFX+co
         pYzejteh+Coolv2koO0iFHp1PcpbEsMNj+yc2nkpxtvEAM1SbyR+TjpGdLek60Dg7TKy
         /AGB+2Na4B7b6vqtN0WPukvqwUSz3IQaafy9ZA4o4QzlzAzG78qK19HJWa24rjkoAE0w
         VoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s43rqcddTJ2FeEIu7EODes4JBPptootjcXSiKSYA+pM=;
        b=BepdkFRGZRj8UO5dhwUJPIRCyg0C5fEDgMvw3VYzHlVQo/7Gg1TXWAt72XvlG/LOjc
         fQ4sawmUgmVkcL/Um69G0ZBqV1G94Li3rkllvFFVhluEHQZ6b5ba+jlOeq+CaIVVlf+9
         xVVoAtENmTHTU2U7YuxoVABly00eB8NLa9OOc75itJSDgk4lPrJvEhvFaLgu6qSra1cH
         5cl6Oxx2CvM827a1rPt5Vo495jieVWwUYqsQMFQJipYytpkfYT3hrWntDBZPt7fxLXt6
         J9Ye9h9fq1nXZmZEy0JTZncdEbudcqmdM2RVGuI6Csb+RWsXeu4AXZHSs+GKZPvjJywz
         nMvQ==
X-Gm-Message-State: AOAM5316kNMGG6dtLrUItgpN639pbC4VZVMSapzO1fAlvZ2OueelMT+n
        +Ze1Vums6IoSOwv2YqYW1/nb6Q==
X-Google-Smtp-Source: ABdhPJwfTj6udKE++Vdr5D1T2JL/RACP9w/++Lia17Nb/xJ1InWWnOvdZVtkzaWin1IaH1TkWgonlg==
X-Received: by 2002:a17:90a:470b:: with SMTP id h11mr3314883pjg.186.1612517109869;
        Fri, 05 Feb 2021 01:25:09 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 141sm8685022pfa.65.2021.02.05.01.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 01:25:09 -0800 (PST)
Date:   Fri, 5 Feb 2021 14:55:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH V7 4/6] kbuild: Add support to build overlays (%.dtbo)
Message-ID: <20210205092507.fdxotdjlq5rjs2yh@vireshk-i7>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
 <434ba2467dd0cd011565625aeb3450650afe0aae.1611904394.git.viresh.kumar@linaro.org>
 <CAMuHMdVp0vGMqoEoP9A7Y7-ph-DYUWdddtChdq_eZcROYTBMHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVp0vGMqoEoP9A7Y7-ph-DYUWdddtChdq_eZcROYTBMHg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-02-21, 10:02, Geert Uytterhoeven wrote:
> Hi Viresh,
> 
> Thanks for your patch
> (which I only noticed because it appeared in dt-rh/for-next ;-)
> 
> On Fri, Jan 29, 2021 at 8:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Add support for building DT overlays (%.dtbo). The overlay's source file
> > will have the usual extension, i.e. .dts, though the blob will have
> 
> Why use .dts and not .dtso for overlays?
> Because you originally (until v5) had a single rule for building .dtb
> and .dtbo files?

I am fine with doing that as well if Rob and David agree to it. Rob
did suggest that at one point but we didn't do much about it later on
for some reason.

FWIW, this will also require a change in the DTC compiler.

-- 
viresh
