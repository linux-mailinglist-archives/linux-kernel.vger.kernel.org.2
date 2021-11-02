Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5644380D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKBVzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhKBVzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:55:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53EB760F5A;
        Tue,  2 Nov 2021 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635889995;
        bh=zdQytRuvrkr9G5j2JmIJsK4ktMBWLhAVf7giPA7NPdY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GrZ2tN5wb7gRJKctxZsB+wKGEncigvAw2Od19UCuWpCgUM2PfDC/f5FdfgGxpvU6w
         mMuxrHrYuqMHaSzatcFbblsB4FDEs86cO8BVmm+ydA73q4whkLqg/XPOtoDONNrVan
         5MQqXKXoT+QKrI/BfZJeU6N0TCkW7nAwdJaho4yHtETeb5pYpH3V3UrCpLFWevgRgq
         VJliYzJzMwYaDf+hh618lCKYDohmfSobFC6YFKvov9tkagQ6UFWkGGWs7qZivIPW8b
         STWLu8MqPDDw1n3gATBqB6L0P+O+LraqEZu72JIlFuF4P/50avENtZDJQ+maG4dBKi
         O2X3EemQkBnQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CO1PR11MB4865DDA9CB07F699288CC762928B9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20211019074030.31294-1-kavyasree.kotagiri@microchip.com> <CO1PR11MB4865DDA9CB07F699288CC762928B9@CO1PR11MB4865.namprd11.prod.outlook.com>
Subject: Re: [PATCH v9 0/3] Add driver for lan966x Generic Clock Controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas.Ferre@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Eugen.Hristev@microchip.com,
        Manohar.Puri@microchip.com
To:     Kavyasree.Kotagiri@microchip.com, mturquette@baylibre.com,
        robh+dt@kernel.org
Date:   Tue, 02 Nov 2021 14:53:14 -0700
Message-ID: <163588999405.2993099.8633091124275421222@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kavyasree.Kotagiri@microchip.com (2021-11-02 05:47:27)
> Hi Stephen,
>=20
> Could you please let me know if this patch series will be taken for 5.16?
>=20

One question on the driver but otherwise looks possible. I'll send
another PR next week.
