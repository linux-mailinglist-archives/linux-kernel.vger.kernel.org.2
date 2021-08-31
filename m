Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3893FC494
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbhHaJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:01:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:60013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240405AbhHaJBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630400404;
        bh=geC6jummpH913xck4Kqq+pCIvyvdgzsG+yQCENcEc+s=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=Xsy/hFufawuOyGmFd7sn0YqHyxwGH4xVnvk3ZGxPY+YJu/+kel2khtWFfKEqUsU8n
         F45N3CUY2pTtTWA7Jd98NvwRZKiVEJjZXQklRqLLQ6dZRP6tid5ZMwxUP9fvm3PHmW
         ObTr6DRjaX7DHxZLGYvQX/fj5VREzvkVHeEjeeRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([80.245.77.109]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1mpdTv3F6O-00mYGr; Tue, 31
 Aug 2021 11:00:04 +0200
Date:   Tue, 31 Aug 2021 10:59:56 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <16f980b95e1f32bb8eb32448f1615bafdc51b792.camel@mediatek.com>
References: <20210822041333.5264-1-mans0n@gorani.run> <20210830155903.13907-1-mans0n@gorani.run> <20210830155903.13907-2-mans0n@gorani.run> <16f980b95e1f32bb8eb32448f1615bafdc51b792.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] arm: dts: mt7623: add musb device nodes
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mans0n@gorani.run" <mans0n@gorani.run>
CC:     "b-liu@ti.com" <b-liu@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <14C40B35-3607-49C6-970B-441F9093125A@public-files.de>
X-Provags-ID: V03:K1:BwjuzFFpOwqolvGter7ofmISuM0KzZzqIugWamQrsY4X2p7n8CT
 RxQJjEoq7gUemkMcDiTQdFGTh7hpvJ9aQks+j19YeRfHjoLxuR3b6XQ/31He+ZeVjTU7mRl
 3MWVjzmO2fOo7Rw0gIQEuLxRAh6fuN9jdzfIujJLjqRAC5WPkDopaGLao0YQCZgh8Zj3Wg7
 Rqio26/e4xvFl3yk5BqmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ztp2H4ZVSy8=:z0bvrzrU2U8eBz8ElEB1NC
 EJqvvijFZl0MEaOGXjlQhIt8taxLXDaxxGFqBMEjHpe9/hR4acAbuvLAq2L78kZbKBHFxKsGj
 dE77eCzSuX2EpBGpmFJVVSpZXQTQuO0izMRIiD/NuEpHezU3XLwODph8B6JQ1UCB3iUtnvGtD
 JUBMAllF7kJkkWoDeweeLYfS8oEOE5blvAOK0oitvSWvWpn/VdHWsSGXP1P199nAJOwwXjtbh
 /LyYH9Ki+CNrwAeadYqjhfp0bJmpAUKMYtZ9A4g5FodVc2Lt4vF2yIo/UWfsOh/t/2u9Exl7j
 HN8unWP432SqGjjTFgcbTrhWEyyBrvgE7ry61X3/5PPtRrtW20Mm1xm9uumd6pmDU7dpCCs8i
 c8rxNT+vaScfXijznBJU6I1+0TbxM86HRjtUJWjpCosdO5VH1LRL1XNiMhbVOXGfgW/jqpCrz
 2NoYbFV19IVaeG5weJlD7Q1J+ZRjryAaUj2uithLm/6nV0Ll7wL645ags20b5yvXaha99c/lE
 /Keh1oqfSQOq4zg3z0gQ0y4GEHHm5Ed7f/p3zI4jCOE5iXv+7jnbmAXF2JQ1MnUqc3tlhDJ5X
 ubjvIwThd8zT8hMMQgkZbaF25yyhvOYm62d0ZNCSo9kqkZWplpMl2OooWsMUljLoZ9eiEuxMd
 bTRL5pgfhxSsuac9bxy1D6sORV7nHto+S//P16U/qG27RiDvVk/zAoB/WfSDdTvg5FIn5DUBQ
 JbSPqnjRFzLPgY5fJOG8mMytYYTySzdOoKuA29GBkuF7DJZ/pDARVnjbEu2dPnkTZCg/9LGs0
 ogObwccsGfqw7a2t0T9MmClYixFtXXXnGjkmM2MfP3iRajcGvicNN2IS4ARWTdXvHWSr8jcjQ
 C88WHczCEInQyZgLItg1Re5kptMt4Vq0zqSTOKKI4ol/2f7rhYuK1/d0S+FQ7jZK3biVhUm51
 GHxi+8/EZC7yJ0CMJNU6Z7sAbG20OMbDln5nAL3MAPE94SQCW/mHD6UNqR1Fz0WPxFxzQzU7E
 auNvNSY0jO8c91S1Z6Df4u1/2Ty0yHOaSqwSj1L6Ohq/CGzYtc09fIEkLKFOvOe3SXg5+5AQI
 STrBcra9Z4eYKy3JUPwIX0nDIF1EjqJ3U5QQeoUuJ1l6qNiijqC/FOBqQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31=2E August 2021 08:27:18 MESZ schrieb "Chunfeng Yun (=E4=BA=91=E6=98=
=A5=E5=B3=B0)" <Chunfeng=2EYun@mediatek=2Ecom>:

>Is the dt-binding patch applied?=20
>It's better to put it into this series due to the new
>compatible "mediatek,mt7623-musb" is used for the first time=2E
>
>Reviewed-by: Chunfeng Yun <chunfeng=2Eyun@mediatek=2Ecom>

Hi,

I don't see [1] (ack from rob) in [2]/[3]

@sungbo: please leave dt-bindings patch in series=2E
You need no new version only for adding tags (acked,tested or reviewed)=2E
Only for code-changes,but then add tags from previous versions=2E

Imho it is better to take my musb patch [4]
into the series as well to make depency cleaner

[1] https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/20210808=
123840=2E176738-2-mans0n@gorani=2Erun/
[2] https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/robh/linux=2Egit/l=
og/?h=3Dfor-next
[3] https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/matthias=2Ebgg/lin=
ux=2Egit/log/?h=3Dfor-next
[4] https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/20210830=
145958=2E108605-1-linux@fw-web=2Ede/
regards Frank
