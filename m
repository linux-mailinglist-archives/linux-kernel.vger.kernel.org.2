Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC333B65B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhF1Pe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:34:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:58951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237395AbhF1PO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624893118;
        bh=lnaS0khkFiNZeGbwO0JvtszbWiBzvDOrzu+0uBQfHdE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=MZ5yCBxHL7wmKQdC5r56PfgyN1dfc/9LaTY3VYlwBPRHRR11HUpDA3s0V9CtJdk7z
         tFY7Bovi42NA0va0lEodFE0bNwR/mrd2uflhZwi+H9eFPFVH/Z3FmPYJxYgbEcoWTZ
         mJ5RaU0Pl5GtEGR0KDAC/FAevxqgs/CYvROoiHGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.107]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1lLXIY3qOF-00fjnf; Mon, 28
 Jun 2021 17:11:58 +0200
Message-ID: <a3351a71cff5d00d7815ff2ef4ec19786d8db0fd.camel@gmx.de>
Subject: Re: v5.13 regression - suspend went belly up
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     lkml <linux-kernel@vger.kernel.org>
Date:   Mon, 28 Jun 2021 17:11:57 +0200
In-Reply-To: <20210628145116.GB3840@techsingularity.net>
References: <760cf981588a31b9a51fa1f6d485d5dbdc61400a.camel@gmx.de>
         <20210628145116.GB3840@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VyIUIPEEyLsTEphaI5KPmcP+gcPAmRSJXxZcf86WEozwKDwwLrX
 k/BYmMv0ctC3SszWIBZhAZfOlvXT6K/tZhxqEfMvb1uwoLUhyYhkzRUNqhvnXYyVZOIYlMJ
 xWqHLFjGYVQ/qvqwUtaQUYaz9GEICWRzJFtpEh9m+O6zsAeQuIFqLmd6+bsv21vbnhLgxMU
 Ad7bUXCnJQHcJz+pnyBSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ql4SHUEsOso=:5LQwE3H+ExbnBghiTkKmG0
 0j80P68f01tQcA1rWP6RBGTZaXaGTmW2bULdWOIzbR+2DkEeymncIULxY07aKcWjzopYqgJw5
 LDF5qTiJhHcd+REwPqXrjWZpQD7Wglz44xHicSaNtBT20QfjRqVwdFnniFTd3RmMNLSCI1gZy
 Wa9RNtACKcn5RUOJb5xEjKsheerogsXLUqQ4o4grRN9cw2ojRRIJlATV1i+/kZ/3XsWkFlyHp
 myRabau63NRxSMLrEGwcgwoKgDr3AGnEaUCHYn+Ju6mlDoeEHhAPAZSgdo2YHDYEZkI8D716E
 fQHbQ47Xz9O354+RhvLlnbhKOPi2RJrZEHVueL06AVIcfL3AG/F5/4xdr270JeJV1lUtSZp0U
 PDIngyMHpePU5tSGhtbtZVpRHTqglfCmmsfbtqLZk4WEbv/ozFAusMQlYb1NSnaGT+BpbBwJM
 vN2OgN0azXvkJ6kcSPJ3v6YvNCujn5eM45boe76mNnbguYat7rASbTmtOCnTLC47OyRiYsrRF
 71Gzbz3z0hrXIfVxW1oTcCFcptjIOTHCxiyaLQgtU+c8igEG+Zv9OXLu8JWZ6AnrDKWhkzALF
 MeacKvIDraE5KqAoB/HrFJtDipP8goP35S/3vVtru7v2JliiVBde1n9KT0sMDFg//usCufEbQ
 DA0h/8kslssE4R1ELRBUiDQpdyn7LtJAPChqGIcoKHUJjF8XRY3zGcbfjkUzpWwJaV9VvkiyN
 3YbFK7Wa3+PsuI8RX0dR0+3LEcevJIVSkTuWlUKNLxAj5hbp1jmBWBFCPrpVE7kYOQBEGvD+3
 nuZ+C2WTootg8AcSk/Zjhb57avE926g3xHTza78oD4BD8LnY8Ea3QMr+UGKpbydsqOfMd/Oaw
 OzyxZlIMGhQQS4EFMf/XOJiwd3kakOthHze+I/TM4r4NCd8+tY+Yx0Z+AwNnsJ4ZWwiN9AsvS
 Nic8g9VA07OdSpVp3KYdqslnr65kU9iFAnjztUe6LYyaPAZgtyE5LvTqPGl3A4Fm4V9fppa4a
 3sZLqmFMLI1mnNZhu9BfqJvg81bs9LAY7b5a6aV5+cxPkuDSfi29nugZiwjODGLJGtl5HVlmH
 zedliTuPYG1KGDHDSeo9E3GnbFBGhE5o+7e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-28 at 15:51 +0100, Mel Gorman wrote:
>
> Hi Mike, this may be NFS-related fallout given that it appears in the
> stack. Can you try this please?

Yup, all better.  Thanks.

	-Mike

