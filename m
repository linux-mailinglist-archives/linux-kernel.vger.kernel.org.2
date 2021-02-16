Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01CD31C8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBPKkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBPKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:40:40 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 02:40:00 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o7so5981105pgl.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 02:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C/UbC0p2B2OI8LGsLZ5ShRFwCgCZxw1TV90u+LaEK7g=;
        b=JTUOJ6gupAdS0Uv1yclSHe2rmXAoZsRRWj/Omhc2ModEO0vU1Jksz+ZVkZ7FUBKuXf
         QY+0aaMIc3YuYsjn2VgKxI/5oS2XF+ydjorVl2FiXl6vjoLHHIgY12ndG31LcErC6kIu
         PVPGgTJ7kXdCHSJyIO304DK1B2XJLK8UXk5Cd20rjOhskehs/hvQuvyrh7boVhK3wIZx
         M1+pkeP0NF3re8WFH9h3yELejoQImB6L6vp2qdMjyVU6c6gspt+9yk+Sl9ZpwcBtONqm
         jIMQdda2R0VGdimnjKpRzgIfNvpIRsLXBp9NFIouIHN/e8gofvB0z9uyRxOlmQgMcb4J
         SvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C/UbC0p2B2OI8LGsLZ5ShRFwCgCZxw1TV90u+LaEK7g=;
        b=M8U414kUCHq/zZF8NQotPSwsULdcQoRqlVh9nr+u2lUqvU/WGMtS0sf7f7iJccX82t
         riLrrX1ZlA/mVN3UuhWcJRO+2PGyniP04Ng9JYW6N89kTyHlJ0oEh/9pMYf87Z9gynEy
         l/LC+G7spISvPqiFmcNI2zBZ3geiV1GccJ91bChtUBEqZ+Kn6fm6eQddYP6hjUPzcuqB
         kVkS20s1Lf0+6k+3TsaPjYQF8M/e4PAO6iwltv+WISWen0t9tccvyxeXOy6dUXX2bdY9
         LTyDCFnsRaaSntT3DXVdrFjRWjWQsTS9d+FILBzODdoeQbcKjcX//EWHLsXhlBK2lzV1
         FpSg==
X-Gm-Message-State: AOAM530OBGnm814SgZrjxevfvQfNRiCUEQRWcjdOC/9y3qlS/8oaPAJ7
        3dWPqf560U+Fp4Po5xfU9DtAyw==
X-Google-Smtp-Source: ABdhPJzF6n1Bw76L8Mvt8EZfVrIA6aPEUV8Ln/oFyqMf3Kv8F8CJsSm2q+7jXG0KMkTrb4NOog9DlA==
X-Received: by 2002:a63:5d59:: with SMTP id o25mr18241675pgm.322.1613471999788;
        Tue, 16 Feb 2021 02:39:59 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id l15sm2390356pjq.9.2021.02.16.02.39.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 02:39:59 -0800 (PST)
Date:   Tue, 16 Feb 2021 16:09:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH V7 6/6] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210216103957.gwikizhtoxvb66le@vireshk-i7>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
 <3683a542d4141cfcf9c2524a40a9ee75b657c1c2.1611904394.git.viresh.kumar@linaro.org>
 <20210204015409.GA3150757@robh.at.kernel.org>
 <20210208111813.oql6jmeaxuq3btz7@vireshk-i7>
 <CAL_JsqK+eM_RrzXnbm2GJGJuVwAjEz1TeTux18Hc727vovbqDA@mail.gmail.com>
 <20210209101058.kmqqjxfjz3alre55@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209101058.kmqqjxfjz3alre55@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-21, 15:40, Viresh Kumar wrote:
> And after decent amount of effort understanding how to do this, I
> finally did it in a not so efficient way, I am sure you can help
> improving it :)

Ping!

Also, where do we send patches for dt-schema ? Which list ?

> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Tue Feb 9 12:19:50 2021 +0530
> 
>     dt-validate: Skip "required property" checks for overlays
>     
>     The overlays may not carry the required properties and would depend on
>     the base dtb to carry those, there is no point raising those errors
>     here.
>     
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  tools/dt-validate | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/dt-validate b/tools/dt-validate
> index 410b0538ef47..c6117504f1d1 100755
> --- a/tools/dt-validate
> +++ b/tools/dt-validate
> @@ -80,6 +80,23 @@ show_unmatched = False
>                                    (filename, line, col, fullname, node['compatible']), file=sys.stderr)
>                              continue
>  
> +                        if nodename == '/':
> +                            is_fragment = False
> +                            for name in node.items():
> +                                if name[0] == 'fragment@0':
> +                                    is_fragment = True
> +                                    break;
> +
> +                            if is_fragment == True:
> +                                if 'required property' in error.message:
> +                                    continue
> +                                elif error.context:
> +                                    for e in error.context:
> +                                        if not 'required property' in e.message:
> +                                            break
> +                                    else:
> +                                        continue
> +
>                          print(dtschema.format_error(filename, error, nodename=nodename, verbose=verbose) +
>                              '\n\tFrom schema: ' + schema['$filename'],
>                              file=sys.stderr)

-- 
viresh
