Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3133E3BA0AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhGBMss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:48:48 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55858 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhGBMsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:48:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210702124613euoutp0242db08db6114ad1b9f412dbda7fb009b~N_gzgjb6R1652416524euoutp02H
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 12:46:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210702124613euoutp0242db08db6114ad1b9f412dbda7fb009b~N_gzgjb6R1652416524euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625229973;
        bh=GTYicL+/1yUaOGFpBvz+ljJJPoHasxAWYxyVH7LSBYA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Hk6l3XAUGnwtyudxcWaU5/0QaT16kgN+jAyukTAT6OLcFhEvGdr+bKX/8QnXHVBDb
         dXPCIXBU3rGsSgNVIJAY+lL6n5m6nCayQ0Zfaf1wtm4ee8Y1yykfrFqRM8KXqsQXG+
         4l3+IV6gnnY8EWRho9NCYNEGZIF4vjeo/mf86yyg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210702124613eucas1p1feb35815611cab1bc8740742bad150a0~N_gzNo3WP2335123351eucas1p1I;
        Fri,  2 Jul 2021 12:46:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.F8.56448.59A0FD06; Fri,  2
        Jul 2021 13:46:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210702124612eucas1p1762911deb37e4fb03adc9239bb715135~N_gyq0r2D0368203682eucas1p1l;
        Fri,  2 Jul 2021 12:46:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210702124612eusmtrp13bd226e935ab5aa2b2dd22a4e9718a03~N_gyp7Y951092610926eusmtrp1V;
        Fri,  2 Jul 2021 12:46:12 +0000 (GMT)
X-AuditID: cbfec7f5-d53ff7000002dc80-d4-60df0a955f67
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.CD.31287.49A0FD06; Fri,  2
        Jul 2021 13:46:12 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210702124612eusmtip22efc10793f5f170ed32a4e12f2946234~N_gx8b_da2001720017eusmtip2f;
        Fri,  2 Jul 2021 12:46:12 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to
 .determine_rate by default
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e21c34a3-2586-057d-013b-6c8ec094d1a8@samsung.com>
Date:   Fri, 2 Jul 2021 14:46:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCAASQUB=cg5EFsBQ4jd3TvcCJzV1=sYJci4ibR7FjRcww@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87pTue4nGKy6JmLx5tERZouf7VuY
        LBbM5rbY9Pgaq8XHnnusFpd3zWGzeLLwDJPFsUUnWSwunnK1ONQXbfHv2kYWB26P9zda2T2e
        TpjM7rFpVSebx+Yl9R47vzewe3zeJBfAFsVlk5Kak1mWWqRvl8CVcaR3P2vBZMGKy/N2sjcw
        fuftYuTkkBAwkTj6+SBjFyMXh5DACkaJiZtuskM4XxglTi36wwThfGaU2L7/KTNMy6V/l1kh
        EssZJa5/X8QG4XxklJjdu50dpEpYIFHi9O/7TCC2iEC8xMa7P8CKmAXmMklMXTmTESTBJmAo
        0fW2CyjBwcErYCdx6rwaSJhFQEXi49HnLCC2qECyxPt5M1hBbF4BQYmTM5+wgJRzCgRKbJ2X
        ARJmFpCX2P52DjOELS5x68l8sKslBH5wSDRdusUIUi8h4CKx8TQjxAPCEq+Ob2GHsGUkTk/u
        YYGob2aUeHhuLTuE08MocblpBlSHtcSdc7/A7mQW0JRYv0sfIuwocaj9ABPEfD6JG28FIW7g
        k5i0bTozRJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFpLHZiH5ZhaSb2Yh7F3AyLKKUTy1tDg3
        PbXYOC+1XK84Mbe4NC9dLzk/dxMjMFmd/nf86w7GFa8+6h1iZOJgPMQowcGsJMIbOu9eghBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHeXVvXxAsJpCeWpGanphakFsFkmTg4pRqYuG/F3OaMk7p4
        NTf8VFfT8fsXNxxzu2G0WP6I8zefDx+Xf/YpXFL7/VTKuVmGjmqzHmrx1Uzey/TEeE7HZIfT
        R+ZU/0r1Tfx/l+VO11sdlZC/yW91gvrV4//1ch1qPSO+KU5ZzG++/WH+lHjJ0FiG+ZtmlKWv
        v/K1csXDX2t/5Omwer5qEj6spMKxqUMm/mPXulcS3Cffuj1gCi1M+3nrq+O+DEY1DX1mZsW0
        ewcO6aZsbarWLtM5vDv91qWp6naL77Wr1ZU/kVmW86FMy3W37EWtt15Ted42ftzBJ8W97+rl
        ngfrt33OqZWSMuTyfNpqxF389tDHWQsr2ty6Vv9vXxjLUqs6UespI4t6xD9dJZbijERDLeai
        4kQAGebPjcUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7pTuO4nGBycqWXx5tERZouf7VuY
        LBbM5rbY9Pgaq8XHnnusFpd3zWGzeLLwDJPFsUUnWSwunnK1ONQXbfHv2kYWB26P9zda2T2e
        TpjM7rFpVSebx+Yl9R47vzewe3zeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
        bB5rZWSqpG9nk5Kak1mWWqRvl6CXcaR3P2vBZMGKy/N2sjcwfuftYuTkkBAwkbj07zJrFyMX
        h5DAUkaJ+fNvMEMkZCROTmtghbCFJf5c62KDKHrPKLH9+gSwImGBRInTv+8zgdgiAvESNw5/
        ZgSxmQXmMklMeSQA0dDBLHFtWSdYgk3AUKLrLcgkDg5eATuJU+fVQMIsAioSH48+ZwGxRQWS
        JX6ub2cDsXkFBCVOznzCAlLOKRAosXVeBsR4M4l5mx8yQ9jyEtvfzoGyxSVuPZnPNIFRaBaS
        7llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwOjcduzn5h2M81591DvE
        yMTBeIhRgoNZSYQ3dN69BCHelMTKqtSi/Pii0pzU4kOMpkDvTGSWEk3OB6aHvJJ4QzMDU0MT
        M0sDU0szYyVx3q1z18QLCaQnlqRmp6YWpBbB9DFxcEo1MC04PGE391eHwtzqQ+YivUWGa+bH
        tSs/WyJw1bRqI5P4xYJ1kjcDPn3eyHSY2V3v+yTObctarh3WXyC17bG4ZxrDD5YcL6XwTEcB
        JcuJOjp6h/4t9J4WrcX6cQ7r9xMn1Hi3vf+04/bZ5z2erlInTsmzLP6jJs3QUrll2TMHu0WP
        /9VEyyXqWbSHXDTmLZmbxGpVoWK9T8GH6air4oGC4MLJzb7ZuyMFDeO3tk5UqhC10zq1y1k/
        VvPIAeaqundVz9NLpquaZW3MjuA8cjH8fKOT0FZR5YzNpfbzYvff0Z7tYa3/ZPqJpuBQG/dn
        7rf2xigFOJZaFui8FFh18k/GhkW+sdfFTj7g+uI2zWOtEktxRqKhFnNRcSIA2f1DkVcDAAA=
X-CMS-MailID: 20210702124612eucas1p1762911deb37e4fb03adc9239bb715135
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210702124612eucas1p1762911deb37e4fb03adc9239bb715135
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210702124612eucas1p1762911deb37e4fb03adc9239bb715135
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
        <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
        <20210701202540.GA1085600@roeck-us.net>
        <CAFBinCC2KB-_pOenpWPknCuHV+CCjhP5hqukSkwD3qwRe6OtQw@mail.gmail.com>
        <162518776607.3570193.14348711594242395887@swboyd.mtv.corp.google.com>
        <CAFBinCAASQUB=cg5EFsBQ4jd3TvcCJzV1=sYJci4ibR7FjRcww@mail.gmail.com>
        <CGME20210702124612eucas1p1762911deb37e4fb03adc9239bb715135@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 02.07.2021 11:19, Martin Blumenstingl wrote:
> Hi Stephen,
>
> On Fri, Jul 2, 2021 at 3:02 AM Stephen Boyd <sboyd@kernel.org> wrote:
> [...]
>> My guess is that we have drivers copying the clk_ops from the
>> divider_ops structure and so they are copying over round_rate but not
>> determine_rate.
> I just learned something new - thanks for investigating this as well!
>
> $ git grep "clk_divider_ops\.round_rate" drivers/
> drivers/clk/bcm/clk-bcm2835.c:  return clk_divider_ops.round_rate(hw,
> rate, parent_rate);

I confirm that this issue appears also on Raspberry Pi 3b+ board. I was 
about to write a bug report, but you were faster. The funny thing is 
that is so nondeterministic, that automated bisecting failed to catch it.

> drivers/clk/clk-stm32f4.c:      return clk_divider_ops.round_rate(hw,
> rate, prate);
> drivers/clk/clk-stm32h7.c:      return clk_divider_ops.round_rate(hw,
> rate, prate);
> drivers/clk/clk-stm32mp1.c:             req->rate =
> clk_divider_ops.round_rate(hw, req->rate, &best_parent_rate);
> drivers/clk/imx/clk-divider-gate.c:     return
> clk_divider_ops.round_rate(hw, rate, prate);
> $ git grep "clk_divider_ro_ops\.round_rate" drivers/
> $
>
> Changing these over to use clk_divider_ops.determine_rate doesn't seem too hard.
> The part that I am not sure about is how to organize the patches.
> 1) amend the changes to all relevant drivers (from above) to this patch
> 2) multiple patches:
> - adding .determine_rate to the default divider ops (but not removing
> .round_rate)
> - a single patch for each relevant driver (from above)
> - removing .round_rate from the default divider ops
>
> Another approach is to first create clk_divider_determine_rate() (as
> done here) and export it.
> Then I could have one individual patch for each relevant driver (from
> above) to use:
>    .determine_rate = clk_divider_determine_rate,
> Then finally I could remove clk_divider_round_rate() and switch over
> the default divider ops to .determine_rate as well.
>
> Which way do you prefer?
>
>
> Best regards,
> Martin
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

