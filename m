Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439D831D3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 02:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhBQBlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 20:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhBQBlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 20:41:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C72C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 17:41:04 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so10533883ejk.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 17:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aUUOJlgDQumqSSsn6b2nMo56O2uNsyRlZI5+0ZRl54U=;
        b=KqWjsFoguTrjWzkyFDr4S7tTXgUIqm3Y4PfT/ofs5LnJNHjNgmSKwxSugOcsMWm6+H
         BoTlzMwTcNvHP6B0Bnl3Xw5Fe2tGprhZ2GPvM0Rn5udBuHOtQcFGiGfqkHM0oyecYmCz
         cKX/9lGvNYEBWtBhHKAZXOmol7P8xRKTge5POr7MV4CoGSMG6hqh5BbhJL2+h+QGvnqW
         XRTkRKha1iNLzP1IjVsvvhGwzrFR4R8anK/4zjo6cMe7tEDTn+DyDAOKf/rR5EYO6O9x
         Py/EDa7UkNGrJnz+qr3Y2R1KVSjVymb7XbkoDsAlcn8nQDCNjTw6dBJlhYLqjZLQow/f
         jUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aUUOJlgDQumqSSsn6b2nMo56O2uNsyRlZI5+0ZRl54U=;
        b=SZuQ5mc/wDCme1KP0Vqk/aq3BU52vB31+xQsWA+ZvLg8OocR0z27JmbBQqaTcNaa9q
         y6WTGDMGT0NiNgm+MnxHHGIE+3wKz/9bMfp2lW1MF4g5klQ4uBldFDDkqT/OhN5WNzdf
         KhOicRKeuM4f550ShSRD/FYdnfaVGobzrUm0wuNXYXlai/iABheP2hn9p+oB535xWw8X
         Goh0MPeC3ZhMTNv/iwu0nf5yy5CpNAu57ias3xBM0PpoKttr5/D0xg1bPpNMdKp+2ZxH
         KGk8bE1mFeyrTHFH9AtisUqn4X+u025tmyyFqK2dHJRrXI54wgyGkLNU1W1qafpQvYia
         6xCw==
X-Gm-Message-State: AOAM530XIaV867ayxIGGGlBy10fh/Fghhnzg2QeZfu7W3KK1R0Igkxvk
        tPmnuVQq+Q9TO8pPIHkCA38/2zZxwnd3NbZo1sgDHA==
X-Google-Smtp-Source: ABdhPJz4EYHuN8wyWFuoFR7FSadeWSJslfOV5vc8kLUvyWmZnsOwRzCVfCl3RDFdPjy97HCFJP5rvSPOVwvdT+ExobU=
X-Received: by 2002:a17:906:1352:: with SMTP id x18mr17937904ejb.418.1613526062947;
 Tue, 16 Feb 2021 17:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20210212171043.2136580-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210212171043.2136580-1-u.kleine-koenig@pengutronix.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Feb 2021 17:40:53 -0800
Message-ID: <CAPcyv4gqXpQK5ta9enky1MrGVYAGa09DaJHod5CK9Ybe59772w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm: simplify nvdimm_remove()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 9:11 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> nvdimm_remove is only ever called after nvdimm_probe() returned
> successfully. In this case driver data is always set to a non-NULL value
> so the check for driver data being NULL can go away as it's always false.

Looks good, thanks.
