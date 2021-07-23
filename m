Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4073D3409
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 07:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhGWEpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 00:45:33 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49108 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhGWEpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 00:45:32 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210723052604epoutp0168ae6e24182cfd8c9673c24e6233770d~UVDf27kG30807808078epoutp01V
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:26:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210723052604epoutp0168ae6e24182cfd8c9673c24e6233770d~UVDf27kG30807808078epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1627017964;
        bh=0HZYyn1Lrf5a0entP/2IzJ3Vlw5h7THwhaZkYOwOIcU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d6wVqMUQfMxPs8pyrTSC7FL6KXerhg8AENlJyWp2qdIj26y/LRzhw/hoHsgLBdMce
         ZJX1hVfCuzoRzxBQ8K8TPSCfcqaqXcR/4PebD/ArX0W4mZUZAmbB2OLpiMhC1/GgCy
         nQPWRxV5kjZ3chSrbPemPECFsDB1VpCHWthfT+4Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210723052604epcas1p47b0fb3cc6d491c9f362cf673382ea0de~UVDfeR7861101411014epcas1p43;
        Fri, 23 Jul 2021 05:26:04 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GWHpw6CSxz4x9QJ; Fri, 23 Jul
        2021 05:26:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.6F.09952.6E25AF06; Fri, 23 Jul 2021 14:25:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210723052558epcas1p3981c73a3fcd94745b7f6b225abd47380~UVDZyQJVH1848118481epcas1p3n;
        Fri, 23 Jul 2021 05:25:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210723052558epsmtrp1d0c184248f4cf9053e93524829f7b01f~UVDZxgkzs1396413964epsmtrp1s;
        Fri, 23 Jul 2021 05:25:58 +0000 (GMT)
X-AuditID: b6c32a35-45dff700000026e0-63-60fa52e67abf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.FE.08289.6E25AF06; Fri, 23 Jul 2021 14:25:58 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210723052557epsmtip15c5b58434dad54817aadb3ac57bfedc2~UVDZjVYbp0413804138epsmtip1h;
        Fri, 23 Jul 2021 05:25:57 +0000 (GMT)
Subject: Re: [PATCH 2/2] dt-bindings: extcon: usbc-tusb320: Add TUSB320L
 compatible string
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Michael Auchter <michael.auchter@ni.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e7b2329e-52ac-5741-7410-ea1608caebbc@samsung.com>
Date:   Fri, 23 Jul 2021 14:45:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <V8qR7ITKe7vHKON9lWSnEHZpmCB0ir2RDmvbaENmH4@cp3-web-021.plabs.ch>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmnu6zoF8JBt+2qVvMP3KO1eLyrjls
        Fs+e/2S1uN24gs2ide8Rdour6yayO7B5bFrVyeZx/cx2Jo+etk1MHn1bVjF6fN4kF8AalW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE742nz
        NuaC5ewVS08tY2tg/MvaxcjJISFgIjFn112mLkYuDiGBHYwSPTcesEE4nxglNu9uhXI+M0pM
        +bmFGabl47PfUIldjBIz9l5khnDeM0pce3YBrEpYIEZi+tluMFtEIErizp2dYEuYBboZJTZ2
        zWUCSbAJaEnsf3GDDcTmF1CUuPrjMSOIzStgJ3HmwxMWEJtFQFVi5tKbYDWiAmESJ7e1QNUI
        SpycCVLDwcEp4CfRv0IZJMwsIC5x68l8JghbXmL72zlgx0kITOWQOP9jLzvECy4SL67MZIOw
        hSVeHd8CFZeSeNnfBmVXS6w8eYQNormDUWLL/gvQIDOW2L90MhPIYmYBTYn1u/QhwooSO3/P
        ZYRYzCfx7msPK0iJhACvREebEESJssTlB3eZIGxJicXtnWwTGJVmIflmFpIXZiF5YRbCsgWM
        LKsYxVILinPTU4sNCwyRo3sTIzh5apnuYJz49oPeIUYmDsZDjBIczEoivEcCfyUI8aYkVlal
        FuXHF5XmpBYfYjQFhu9EZinR5Hxg+s4riTc0NTI2NrYwMTQzNTRUEuf9Fvs1QUggPbEkNTs1
        tSC1CKaPiYNTqoFpwvMNoumsKpOfNPyvPruHheHVe1H1o499qtdfFDx4w1f+ge7uqfz/1J8c
        vGotVnFyCo/A5nuFCiZZlkcrT0qLNGtL1ayafvXWtnsZhh5nWbsfZF2clNDS7SX55IDvEoO7
        t40WcEg+EJgnsmXNrkfNH7aY7J5S8PL6hO7vftNab1/cUFig+EiudnNwmeSLRZmubSmvXU9w
        ztwpcfjtBMcHb7YWmp3/8GHqTllFtwUqbQpRiaKVQg/KKoNMN019sXdya+pj240uEqcZmX8y
        9NpUFfW171tv/iR38q1mtjDlyjlC8y0zNSYvDthj6bD2p41m7cWv6XMWqLxKmN53w8/F/El6
        mvys3ucPv8Wd2SK9WImlOCPRUIu5qDgRAE6nPDInBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnO6zoF8JBv3rWS3mHznHanF51xw2
        i2fPf7Ja3G5cwWbRuvcIu8XVdRPZHdg8Nq3qZPO4fmY7k0dP2yYmj74tqxg9Pm+SC2CN4rJJ
        Sc3JLEst0rdL4Mp42ryNuWA5e8XSU8vYGhj/snYxcnJICJhIfHz2m62LkYtDSGAHo8TZ7htM
        EAlJiWkXjzJ3MXIA2cIShw8Xg4SFBN4ySpzrZwexhQViJKaf7QYrERGIkrg1NxZkDLNAN6PE
        7zlrWSFmLmSUuHl6CRtIA5uAlsT+FzfAbH4BRYmrPx4zgti8AnYSZz48YQGxWQRUJWYuvQlW
        IyoQJrFzyWMmiBpBiZMzQWo4ODgF/CT6VyiDhJkF1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvME
        RuFZSLpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgiNIS2sH
        455VH/QOMTJxMB5ilOBgVhLhPRL4K0GINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJ
        JanZqakFqUUwWSYOTqkGpivy8eIc6T0s9yo3bKjvyVy0TpPrfEL7zLAP+jfiivnMTfpdRb1a
        +rpvfvezlLH9F/vuqmlW6DaVQPmie3sqqievCMqdqB98UPOd8kc1lQNmLWk3mO/deycwR7fy
        zIyrGkp3Hd7Ut2v2XOhe9ZYlyENDpvnoWwOW80t3cD+tf8XJfut6Eh/byhPNzGLLijKrgzj1
        S1k7g29PPDXh/qIHnmHvtn//VjGlY/bSRg53S54Qy1Mb75f/7l16VuGHU4tO0ZPLBseSV9w6
        tKYxiWvZqQfVi4pn/Gg94bb7s8BW+R/Ny8p1Cosvu1R/Vv4a3B68UnnK8rPvM0Q2Twv1U2Zo
        ecypxnFy+9mVb4Sk7TJYlViKMxINtZiLihMBWBL9cA8DAAA=
X-CMS-MailID: 20210723052558epcas1p3981c73a3fcd94745b7f6b225abd47380
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210714174347epcas1p13ad5fd7b1f84d91367ff3f11a5c783b5
References: <CGME20210714174347epcas1p13ad5fd7b1f84d91367ff3f11a5c783b5@epcas1p1.samsung.com>
        <V8qR7ITKe7vHKON9lWSnEHZpmCB0ir2RDmvbaENmH4@cp3-web-021.plabs.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 2:43 AM, Yassine Oudjana wrote:
> Add a compatible string for TUSB320L.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../devicetree/bindings/extcon/extcon-usbc-tusb320.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
> index 9875b4d5c356..65fa98bc71fa 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
> +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
> @@ -11,7 +11,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: ti,tusb320
> +    enum:
> +     - ti,tusb320
> +     - ti,tusb320l
>  
>    reg:
>      maxItems: 1
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
