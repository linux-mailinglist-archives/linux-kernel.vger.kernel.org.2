Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8656A3FD2BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbhIAFNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:13:05 -0400
Received: from mail-mw2nam12on2090.outbound.protection.outlook.com ([40.107.244.90]:18049
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241800AbhIAFNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:13:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJGvxUSMdhXS37DePL0QwtROKPAyofsHEmsdr94WWEEvWlKrAirDq8bj+8doQ/ADH4UOi8X/j9FiM3XrPJ2WD7cgcxq/5FOrG6Hv9f5thUCLy1xzyye/rAVhVMbb0tTGMU5gwNawVmrJLmn/+1VeHnYY/bTPe77PFeL58m+4W57PVgBEnqzUejk6ch8JEvKTZeaH5cLgWD/IQ7YpIvQ9y4gGv6s7PXGiEY1IfGPtrMQebkepCExv0oWEpP7oE8srMjlySBqe2QLCoq1GL0cUaDX2p6eIj9QEca8eQ2cNEq3hUKWJp5A4xXFhSCK+jp5olXVOxx1dZ4Rew7ZLB2kaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvrjrVUHghjQwDnDu5I3uOzRKsUlRoxutkS/fKUISlM=;
 b=ekPvTFnnObDrD0w/4Qd8sn8rjKRXsEarBm76c6Az53FOll+cwL0a0fvBITFNmT8Jq13O3G4rgghgRrpZUjhdn43t07+3PKaApsdk335klgePysscLGhbDfkm1eyel/uVuCKq1ngcYX5MeELV4pJvPhgtEl/hopybFG07TVDxQlJVKbEWM6iG4ykpyvsPPKveJr01RFtrv8FH/2mv6+NCaS647aHC2o6u05jNP+msH7PbwK1W+TW/ympbFTd7HJx1BqFhMz+vqPoI0b1PBaASD4THPoyGx33u0BTk4EYhkq7LVgpUnD9zInDALQUfBtBDbu+bj3qW9TqCOtVdFrO5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvrjrVUHghjQwDnDu5I3uOzRKsUlRoxutkS/fKUISlM=;
 b=YlbjdoeRwGLcWM0bwuHWYwm3JQcig+FaizSN05RPRer8m92ejHzJx5iPct4dRUc831wI+0fIgEuG1AGisWq/inzIMAss4zasAd5T6WA10FCNHT5p97OXAsxyw+KW+6b0+iylkhxfzdyp5i4Ft8NThldMIgJ0RsgjkPAFv++tzHo=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from CY4PR0101MB3160.prod.exchangelabs.com (2603:10b6:910:45::12) by
 CY1PR01MB2154.prod.exchangelabs.com (2a01:111:e400:c615::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Wed, 1 Sep 2021 05:12:05 +0000
Received: from CY4PR0101MB3160.prod.exchangelabs.com
 ([fe80::d054:80e9:cd9c:6c20]) by CY4PR0101MB3160.prod.exchangelabs.com
 ([fe80::d054:80e9:cd9c:6c20%6]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 05:12:05 +0000
Date:   Wed, 1 Sep 2021 13:10:37 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, song.bao.hua@hisilicon.com,
        linux-kernel@vger.kernel.org,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YS97zTzN2dTpvKMn@hsj>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS8HpUz9FUcFWt0V@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS8HpUz9FUcFWt0V@zeniv-ca.linux.org.uk>
X-ClientProxiedBy: CH2PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:610:57::11) To CY4PR0101MB3160.prod.exchangelabs.com
 (2603:10b6:910:45::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj (180.167.209.74) by CH2PR12CA0001.namprd12.prod.outlook.com (2603:10b6:610:57::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Wed, 1 Sep 2021 05:12:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba4d9b6b-7fc9-4497-4dbf-08d96d0709e1
X-MS-TrafficTypeDiagnostic: CY1PR01MB2154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY1PR01MB2154B8EB8811A1D8B610E03EEDCD9@CY1PR01MB2154.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ANHQmcPekdiePPRm3NEBUhNwzTQE1blbd/bmAhnS3JCm8RHJVXwmSL5aKNAq3X6YBHZW+9NhveWcI4KdXwAG9DA1JgNcsOZgPxXZJk/9f+wvaXd7+4SBOOYqqTDUxqvfaPZyuHrLqJhFpWfG8uMNKCGcKW9uD83+sFJquRlGWdaPRzdHGxzSJtd7e+Ikado8dR7DEyxnfB7UDt2xAe0JxkfPAKvC7ZTvLfKd/2+rRBePqFePKHY3fC6wN1Oob2qC/M8h/791KUnNB3jAf2U7gtafEquaN+iROFBCQMKqXneZA84oU/KQfkUsFW6fgGAUDxejfDvGgYxo4zTW34bzAIEKTgoJCVjck6CMPJqoe3HQOrUAJnYxmETjKnXJhj6fHSNa0qt2OSZ4qeJEO7I+NyLJ7H/eIS5waW1rQ0gpKEQKPsmkPmDQM6zQ1ns3WNdmxZ6yCK1s6H5mLqYV5CSu6eollwqBC2XwSrKemGH1SYDQu8ag3AMtbakZXtMw/yhURruv9uNdBXk6zQXAt2mzvGVaLNQvWRROBaBK/YNLlFTjCybRa9KGc1ie7FyWnbKEd9wsHB27cz/GOwsQEs4I8Jhwe/7/3vj1uPfUEicbEg+eeQP8RMaNYgsaECSb43kQzQTKVuowBCMpNKin+7fXUaEUu6h2RmYwyWEhcalL4OwO/iI91SQHxi/lhJSMnJpYSl0GTHK9/hAG9VSxaCbvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0101MB3160.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39850400004)(83380400001)(54906003)(9576002)(316002)(66946007)(9686003)(38350700002)(2906002)(86362001)(6496006)(66556008)(66476007)(4326008)(4744005)(52116002)(8936002)(107886003)(186003)(38100700002)(8676002)(956004)(5660300002)(478600001)(26005)(6666004)(55016002)(6916009)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?F5vhYLY7FOrQNwa3VvBfdshaMLYhLxDgc+6uHT2aanG+C7mkNG3vcBktBg?=
 =?iso-8859-1?Q?7Tzwwgb1332tjMxOCzqQt4A4ReXkQhwLZGZX/eIbsDXTpZSNUusRgiU3qy?=
 =?iso-8859-1?Q?NUfJlNH5sKxHSb+jt/kZ46mys/gXoDpI+cGW7JUg+qnEvXFYO7D+qMyxjW?=
 =?iso-8859-1?Q?rmcsXkCoPPzPjS6VHS3suSjQP0NlymMogK5Z30wq5f7/N/KUZ9c2CCSnRp?=
 =?iso-8859-1?Q?V9kyNgreAVtKLYA9l0zTkSb1EW31743PsA77hJ8QmaYAYQMEN/E8pfnVG8?=
 =?iso-8859-1?Q?eiva3H1HOVbtGA88NE69ssJVf3IncCyiBn/KF5tDBObGbQ37Cs+S1SdnEi?=
 =?iso-8859-1?Q?AridG5lqNdV7J+96aJzen1NyuQ1YIaNmFDfAeO/yOa4bsI1dukzmu2c0/i?=
 =?iso-8859-1?Q?g32iVIQUSnGi+6lDtHHTlpCaN/JCilX67ZbTHvrt3lpvwc74dwB1tiTY4i?=
 =?iso-8859-1?Q?n9uwggfFmhnFC5RFjVfaGhWs09C/2mwFpznDrFDfznZG38gtf9yRI+4lfx?=
 =?iso-8859-1?Q?m4gyGnevt6uFJdi+fJI0Qzb16JmCKhOxBw7iUfkd59VDTLmox2eAY7Ertr?=
 =?iso-8859-1?Q?RIytp94JG/2e2r/94A6F8TogRBSaPDY6ulcX8sIixacslS0OWlGxi54LT6?=
 =?iso-8859-1?Q?NtR9/wktW7iVpIpgJXHBJkDULZqW4zs4rFpvRQONBrv/D7mCdvxVaevmeS?=
 =?iso-8859-1?Q?J8A9+7EdperybVBbVWTjhW9DFphrSYwf+QBz0zzFdtyfRN6HNWsNYAzhiJ?=
 =?iso-8859-1?Q?DP3P3/NRUhuwo2HXBdMgSfTYGZdX60TL5bvkCoUqrAVVnvnvzcPw1aimHh?=
 =?iso-8859-1?Q?MVjiMgZVxjeR+ACIIJ8F3WcAkI9kWCg5SSk17VQD1+CKc7PFbRbqrbWxnM?=
 =?iso-8859-1?Q?zQORO9FP5RIg+Y+gnzo6UG9fyfm8hHS8kJbv+s3Lj43AGv539GwBDaUix0?=
 =?iso-8859-1?Q?HnBNqV4rNavOdO3QoHAqHGKGqDw75KRsQN+wPCTZZafNN7HCMtq6JH1t1u?=
 =?iso-8859-1?Q?JP5syHZHCrc9e3DN2B6wtkNSqbz/Zr5C+zHuZQuFwjjWegK780FyOrA6p4?=
 =?iso-8859-1?Q?xVw2zymCTJ0wUQMQSccmZ1H6/Km260KZa9GDfKKM+mbmSw7zRSoHu3390A?=
 =?iso-8859-1?Q?aRhnlEqwUdfPKHYemnIchIVAKxWGBgkJg2tlKq8a8jJ/QKtW093XJvsqiB?=
 =?iso-8859-1?Q?R7GA5VwRwMgJevSVcjC4jfZfP0FEoXwrKTDZNIrtK8hc61Bvd/OdtnptXk?=
 =?iso-8859-1?Q?L7UxHqRpKaJja+rRFTF0iVWl7gG5Y+8V6U/g9vAGbv2c/Y+9mczf7XRIFU?=
 =?iso-8859-1?Q?rfRQigb/0BRFf1Y35weh4Ia8STmxJEDCrx4kZVlY6qECG4Tsh7oOpP+CDh?=
 =?iso-8859-1?Q?ITffN0cRMy?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4d9b6b-7fc9-4497-4dbf-08d96d0709e1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0101MB3160.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 05:12:05.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSaorvL8TTNSczTl87CovHnRZjYzzjLCsGT0+N+Nas4sDys95ah6TxnoiH7fShjOJF8OMXw4nTI4AaTqe+cStK3/iXRbVZ3Y6S4LQ7XPf6i36cmYAffkUwBV7MaB3Vh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB2154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 04:55:01AM +0000, Al Viro wrote:
> On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
> > Hi Everyone,
> > 
> >     In the NUMA, we only have one page cache for each file. For the
> > program/shared libraries, the
> > 
> > remote-access delays longer then the  local-access.
> > 
> > So, is it possible to implement the per-node page cache for
> > programs/libraries?
> 
> What do you mean, per-node page cache?  Multiple pages for the same
> area of file?  That'd be bloody awful on coherency...
Yes. per-NUMA-node page cache.

We can limit the files to program/(shared libraries) which are read-only mostly,
and do not need coherency.

Thanks
Huang Shijie
