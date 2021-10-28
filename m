Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB743E3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJ1Oe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJ1Oe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:34:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFCEC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:31:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b12so6139807wrh.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=G1URQ8lQTbKqKyy5iIiPH2GPZERZgQDiwncSKKtO3yA=;
        b=fBHmbjTKwbBV7gQItocG0wuyAy3bf5EBgQUyDfKMLm92xGS1KdK3ElxDwMrekIV/4E
         18hPsWS+TZLWBXgxqV2DRCkEmPmmrhlQr7l17pJNdFgJnGJq7DCwbJ4wWX7+pbdvEryR
         flIqtVwIMaUVc+HS+/siJkB7FS+4KrSgg18nvaVRFGw6phKW/ekqUUgDLQzJDvIubANZ
         gPqWACUta8NJLoG+p33Dzh7cgf70VksltNhfBZDIPlKyt1ZG00r4MukiwYgHHo7YHMiy
         YYp6EB0Q2GgmK7WVo3cxKv6F2V/PUcJ67OYqlVYWgUK5xbHlm4fGxO7HWHSpq5COJAzV
         Q/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=G1URQ8lQTbKqKyy5iIiPH2GPZERZgQDiwncSKKtO3yA=;
        b=ma+WHanL+Glu5C6/8u+bfU4deG2MNAmyNhblCNmMze3Mr+z82ZZQQwp6XQesDBGSbz
         2N/XWOhFwb/zWHUWhkX9uZW6Xh5MpZDUtH08hHu/0ptcwIAErURsdms2TXPVH79p0gHN
         YsSr/kdH1vosCEpCXR3e6r/6S3yoeOYerL1Iuk6feKI9aWjw7Dz9+WhwmJXKpeItwSff
         y3J0ta/HLcCog5I4Kjyuzpf+kWRJ5PDiZW6uP1e3oNMkgzc0pexa5yXop1rnw2IsaUUD
         NKtjwgHRPnti1J8tU6tu2gKO0YbiGeeFRbVTUyhRx+1ufDHKlVbGRlSvhdkwO5zX9RsU
         9MKw==
X-Gm-Message-State: AOAM530tWZgdoBgAToLWOWtImBYtaYKUnKM6CpYDlBXoWhPk+qgvT/2s
        X8kx5a/exmRDGV9Mpy+gle4=
X-Google-Smtp-Source: ABdhPJxHXS8cxJcuL94+fXL/rbO0pFVs3/yhI0DSigN5Eupyioy+0wUxoViDjj0DOECe+w3Vvem8SQ==
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr6074015wrq.411.1635431517243;
        Thu, 28 Oct 2021 07:31:57 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id c16sm3211643wrm.46.2021.10.28.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:31:56 -0700 (PDT)
Message-ID: <186358f460f2093dc8a60a8120be3dc6f830c81f.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 4/7] staging: vt6655: Introduce
 `data` temporary variable
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Oct 2021 15:31:55 +0100
In-Reply-To: <39890856.3BBMun7449@localhost.localdomain>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
         <2039159.k92FijXA2m@localhost.localdomain>
         <alpine.DEB.2.22.394.2110281332040.9518@hadrien>
         <39890856.3BBMun7449@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio and Julia,

Thank you very much for looking at my changes.

On Thu, 2021-10-28 at 13:21 +0200, Fabio M. De Francesco wrote:
> Hi Karolina,
> 
> I think you are using redundant parentheses in "* (data ++)" but
> understand that those increments and dereferences are equivalent to 
> "* data ++" (according to the C precedence rules).

Yes, I added them on purpose to improve readability (+ that's also my
preference anyway)

> While we are at it, please notice that Maintainers of different
> subsystems may see this topic from a different point of view and that
> they might very well ask you for removing those redundant
> parentheses.

I understand, thanks for letting me know.


On Thu, 2021-10-28 at 13:32 +0200, Julia Lawall wrote:
> Would it be better as data[i] ?
> 
> Could there be a better name than "data"?  Perhaps "table"?

Hmm, now when I'm thinking about, it indeed looks like a better option.
I would even say that `data` (or `table`/`init_table`) can be only used
in the AL7320 case and we can go with `al2230_init_table` for AL2230.
The line would be 61 characters long, way below the limit.

What do you think?


Many thanks,
Karolina

