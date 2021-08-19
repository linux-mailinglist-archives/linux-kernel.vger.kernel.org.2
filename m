Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9404E3F2009
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhHSSlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHSSlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:41:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF12A610A3;
        Thu, 19 Aug 2021 18:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629398446;
        bh=gMJPa1/ZzT1TF1P+WXUcNaxPilysuEWN6jt3adeX1I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lgw18aMfS3Ok2Wp08myHmq38irjoDJfIKKNOeO32MzeEnbEAfbVmwDdUWqtjmfXhy
         8ShqQRjFvsuTqSdudaHXol33C+i4xsjHeLJNK3vXLkOpxt8W/+gRcifgKsB2HE67VD
         F9xBxVg9Jo+GrD/Dt0Ym4YHoAwODjeqpGWWCftWuvmM03PQt3IrbkIaLC6JTH+c/qq
         ugtYx013oXxtiwZlz1kLVCo4wSc2FPsFADfN6+BS98/eqsBIjliov0MuFB5d28E2gD
         5sa22YiWerk21UUZu75xtAKEwo6uhLrwDvvH4bVActG9Dezqw97uE6dw1y3f6cRMwV
         dxfzgnf94K5Xg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 04F8D4007E; Thu, 19 Aug 2021 15:40:42 -0300 (-03)
Date:   Thu, 19 Aug 2021 15:40:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Namhyung Kim <namhyung@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf, android: fixup get_current_dir_name() compilation
Message-ID: <YR6lqjegeLPEJ13t@kernel.org>
References: <YRukaQbrgDWhiwGr@localhost.localdomain>
 <CAM9d7chOtKDTmiZz7EUDX76BMWRzWJATmJZLcTiLeu5k_qRg0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chOtKDTmiZz7EUDX76BMWRzWJATmJZLcTiLeu5k_qRg0g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 19, 2021 at 09:28:13AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Tue, Aug 17, 2021 at 4:59 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > strdup() prototype doesn't live in stdlib.h .
> >
> > Add limits.h for PATH_MAX definition as well.
> >
> > Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
