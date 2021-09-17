Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4040FA3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbhIQOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:35:20 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:35176
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241700AbhIQOfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:35:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTBTI1YFhsU36ua5M8tYTduv5NeidnFBeeYG5lnCmJr8kBqQouYRoU8IPdZYDoDdT0f0MWsja++ZNFhgSZi7rnVlR822oVP+wfcRjKUHlN07VJYxIwJnEsIVUrRAgiDOXeuefiACmK3O6GhVH3aN7tbPz1RyPdgMCof0WtQENwjoKaMLdIOfRAMpy0ZL+KXsKRwAO4/gh1lAyCj1AIdbnkhavZWZpX9QsppAs4DcoKxHKxxFOJ+jJU9FYJaBadtIapA8RaWK7QGw2LJZYArVBCsZx8++BkIgKU6odawhJbijQylUFA+3RcSuNK0LJix6poa6LcctNF6+duwDZZzsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NBX5DSj9/ESMzQVtg68P7+Sy/xEYIjsytANi/BjzSR8=;
 b=BYnQ55Vcja0fUzFwk6xskaQKHPntzvEiBrb/HBtz7NK9hzJfva8T06wmmPEdopCDeOlYr2QTsndZGjAtziWbmKajw4H/o5WFhqoCKcZv9oDKymPKhep9E3YlHlJ7pxKTlR6zkExB0ds/2IPpzHabP9AV/vrOz1ob6iOlkr08fSCPYuh1xDF9Wkx8bfu3Ckta/E2gzlAztDJEmpxjH7j9cxIfeemE9jNAwIVqyncHhqFujx1SKIjMEDvzH5Rny1MqEXfg1mXODZpNMAN6FIoj2burhAv2MWhP8tPDTgh5NDHdgBklle4C5O3Tz9ZoJdAgTeR1eR0URvjnxMSnsqSSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBX5DSj9/ESMzQVtg68P7+Sy/xEYIjsytANi/BjzSR8=;
 b=e18uY6ERx0YX5uiaAAiS+V+53x5YDR5PM0SM4lgqDMvVR57Lz65BG5jek6aiYqRQCFUOS69/ebEZPT/Yxw1cnKIy+JlxXRw5txei7wa0zWSzTkDH8xxiyp8WpA3bNXXV8h4zv0/Y3PKrof3lMaQrpNDNRm+Yk6K8VRLn5wygPm8=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SA2PR11MB4875.namprd11.prod.outlook.com (2603:10b6:806:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 14:33:55 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd%7]) with mapi id 15.20.4500.017; Fri, 17 Sep 2021
 14:33:55 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Srivathsa Dara <srivathsa729.8@gmail.com>
Subject: Re: [PATCH] staging: wfx: sta: Fix 'else' coding style warning
Date:   Fri, 17 Sep 2021 16:33:50 +0200
Message-ID: <3459215.8gJYjjsDaa@pc-42>
Organization: Silicon Labs
In-Reply-To: <20210914143107.18436-1-srivathsa729.8@gmail.com>
References: <20210914143107.18436-1-srivathsa729.8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SN4PR0601CA0004.namprd06.prod.outlook.com
 (2603:10b6:803:2f::14) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
Received: from pc-42.localnet (2a01:e34:ecb5:66a0:9876:e1d7:65be:d294) by SN4PR0601CA0004.namprd06.prod.outlook.com (2603:10b6:803:2f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 14:33:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2513bb9e-3cee-4adf-3f92-08d979e82d9d
X-MS-TrafficTypeDiagnostic: SA2PR11MB4875:
X-Microsoft-Antispam-PRVS: <SA2PR11MB487538273622A9E1FB95C25193DD9@SA2PR11MB4875.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iIRWFOmFb30CX4rNOrlv8Um6t99plDcrTaMQWm0KiYgafOdDR1L9sqqTYCZNMwV5xLwSO/fNmnPjwYYRC0YQA4GVIOoa7j6vPcfafCJTlRI5lj6eeU1auIQ1gTPBWwyUOxyl4o3gSJhLlLWw+SQeiuZ/zBdUomcZgJprTM1bQ6oJwltM/RVeVRn9cfjpWJ2jLVBAK/M7iMYq0QadWNTMRHhEvQ3NvhsAYhjYfZ8yZzZsuM7085ahF81Ob1joHAqiMX8ypbM3n/jaC0sKzcZNCyeqRATNXaxgjo57PyAqeiMy3WS5371W5p8uuSBCjRSfPJRKydZn4j0c+iTiuILypLtYBwjfvLN1qLeWCuKj/j3ITN0cJHUTrewx+/I/ZHvRUqJGJHmN9bFtTirpI3neRRnkF8cXYYK5tjB1yEM3CEKn8B5deDcft+KZdnz83khNcxLME7oS/jKGbGFwnrbNaBphTXn6DQ9tCVJ5WkVhosHCM8UsGpPXWVskaLfPpv1dVFTTzswaFtT+S+TM0aq0gcia1FLNVQJg8oIBNMhGtAIP+G6QKkeogGsifPGq64n2pm4wcCyczzbKO2Gc8UV8oHfDQmrKPDfhQDrTjJUD7SlS3+C3OCxy1aWV0nBex4YTdbCd4SNDgkGDA0d7x5o8/c5RaYxKyRGIACEhBduXU5IN1UDosxiBqaaWhZ53Dk4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(376002)(136003)(366004)(346002)(33716001)(86362001)(83380400001)(66574015)(9686003)(186003)(66556008)(66946007)(6666004)(6512007)(2906002)(66476007)(6506007)(52116002)(36916002)(316002)(5660300002)(478600001)(8936002)(8676002)(38100700002)(4326008)(6486002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3Y6z83dZM5JumENccGd7mp9zcImBBRJQzRm5z+9m2qenUdeaf302/1ZHEx?=
 =?iso-8859-1?Q?u+d2Hxu0v+mNrvV7SvWSIlYTt5JEgVgzDOlJERWCFTMuHTtks3Dj532CoD?=
 =?iso-8859-1?Q?Avtutx98JblSDu2dGBoIOKorPcKD2T3U+KE5cg1TwU4xS/4uf9BFYrG2qb?=
 =?iso-8859-1?Q?CK3W8s3fm7oiItHAGzQc7afj0URnU4MFpfr6phPwcTfakwFBjqR67dxnnD?=
 =?iso-8859-1?Q?xhhhBhsvnAef/Yy9VC0tNfLMJCZsoVFyVuEK66jPd7X63k8YNd4YWzxpQm?=
 =?iso-8859-1?Q?YT7J8MGvQ57BI3WxRF91Oqtulpoi9vAzPTQDPUmwAnaq+dfsjH02yU64XO?=
 =?iso-8859-1?Q?guboHUxbu/IePmBbh9RvfxQMondi6313GfwQdOn6L7LwFgyj1wMfymlxQF?=
 =?iso-8859-1?Q?kw9/86y49AmndgJHMTky2UtLCyw1VYx11hEqCFA9GXzWOOFvFwbUnolcPm?=
 =?iso-8859-1?Q?Dyz3hvl7iitem3bFiirZa8Lpsyf7QR6Ubsddm7CS8oUbFfZxRIQL2pv8KF?=
 =?iso-8859-1?Q?HgNjNkJIn/yOeQt6Wh9jEuub9YyZJG9cGL+7UmMShBScmLX/Q01+vc702j?=
 =?iso-8859-1?Q?dlz7WVYUnzVNlwpsLiQSYb42gsfIBMK06bemwVI7HThB8+CRV32IzjzlYt?=
 =?iso-8859-1?Q?eWWHg0yfTT5+sHsP6uu5Ul56yaRfvQD7x/I56+JisNdoGCkvvXxcDtPXaW?=
 =?iso-8859-1?Q?RSVieU2gYhHoK9kMS67AwoDperzkG39QmlnBvFyJorsaGU99uTeFEY1lF8?=
 =?iso-8859-1?Q?tsXKm59nuaN473mtgHrRQXp7HKbFo93HBWOJHECL75gLnU6mRUZ/Fz9bS9?=
 =?iso-8859-1?Q?zsiGFn8GeHqCcl2Ug3f3gF7pUpUfklnQCmZe2mLUSTJ2S/hiT7gFgCReud?=
 =?iso-8859-1?Q?oAxyaqGNmDQi/IZWwB/kSOSHSOjBSJl7b3AcmHl4h2yVJzXlR4HG0yjmJH?=
 =?iso-8859-1?Q?BkPJJ62A/vAS72ATK4xoGnISCRPsK2XTRjmqIhBZ/Bu/M4XJgRy9rLj5Lt?=
 =?iso-8859-1?Q?SexH+Rrefc7ueKxLI+Gei0BQLfNEfYk5zStnU3sl5/yNfjHP3solBBgg2c?=
 =?iso-8859-1?Q?VdUjm5Vq2g9oB6QA+xFq79oFkjkxlNdiLpxmx9CUE9Xcprq3HYTKs+YLCi?=
 =?iso-8859-1?Q?TpP1GvX8+qmn1h2dngACHOY7CMumkGXvYhUJmhBUM8NYkoKC0z/uFY3zWz?=
 =?iso-8859-1?Q?8cyuqD99O2SO8N6DCjaWhd3ipAGGaMtFSXm9AhEVX7Qh+kSuZhFDK3kBE8?=
 =?iso-8859-1?Q?SvZx17/oTLEGcMr+6Nwhyar5afeGkm43ImgexMNFfGsRPufdFHusZV1obz?=
 =?iso-8859-1?Q?6d+Izy6AMeS3kVzJfNGQvuIo8FBXAgScaRe+dexcyVK1nLfih5w338lJpJ?=
 =?iso-8859-1?Q?lS3YbwW6J7y5cvB+6qMyIyq0fUu68rJvV3TiZV0wD6Db6+V8F0Lk4CMH5v?=
 =?iso-8859-1?Q?9PI6CR+QVEV/02wK?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2513bb9e-3cee-4adf-3f92-08d979e82d9d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:33:55.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3Ew5anPUwzrdmGa7AwtNE9sx6D3JP7BPoR9KCrHv6Cb8MeP4MdPIjkSEOkJLhBntM7rhKm0FARaSh9a2nUBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4875
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Srivathsa,

Thank for your suggestion. However ...

On Tuesday 14 September 2021 16:31:06 CEST Srivathsa Dara wrote:
> Fix 'else is not generally useful after a break or return' checkpatch
> warning
>=20
> Signed-off-by: Srivathsa Dara <srivathsa729.8@gmail.com>
> ---
>  drivers/staging/wfx/sta.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
> index aceb18a1f54b..23c0425e3929 100644
> --- a/drivers/staging/wfx/sta.c
> +++ b/drivers/staging/wfx/sta.c
> @@ -169,19 +169,18 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif,=
 bool *enable_ps)
>                         if (wvif->vif->bss_conf.assoc && wvif->vif->bss_c=
onf.ps)
>                                 dev_info(wvif->wdev->dev, "ignoring reque=
sted PS mode");
>                         return -1;
> -               } else {
> -                       /* It is necessary to enable PS if channels
> -                        * are different.
> -                        */
> -                       if (enable_ps)
> -                               *enable_ps =3D true;
> -                       if (wvif->wdev->force_ps_timeout > -1)
> -                               return wvif->wdev->force_ps_timeout;
> -                       else if (wfx_api_older_than(wvif->wdev, 3, 2))
> -                               return 0;
> -                       else
> -                               return 30;
>                 }
> +               /* It is necessary to enable PS if channels
> +                * are different.
> +                */
> +               if (enable_ps)
> +                       *enable_ps =3D true;
> +               if (wvif->wdev->force_ps_timeout > -1)
> +                       return wvif->wdev->force_ps_timeout;
> +               else if (wfx_api_older_than(wvif->wdev, 3, 2))
> +                       return 0;
> +               else
> +                       return 30;

I am not a big fan of blindly applying the hints from checkpatch. With
this patch, it seems that the code in the "if" branch is an exception
and the rest of the code is the general case.

But, it is not true. There are two cases, and the author (me in fact)
attended to express that that by using a "else" statement.


--=20
J=E9r=F4me Pouiller


