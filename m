Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2852415905
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbhIWHbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:31:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29200 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhIWHbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:31:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18N6WZYP003039;
        Thu, 23 Sep 2021 07:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=vIkZ5qBAcqAZM3SHxcSjT/eHfz+b8nDiEmOYjfE48ik=;
 b=gjSb4grBATQWB28KnrKqEDDZ+jgZbKecPtMoUWoi/Ep9fWa+o7iHwfldGotCZVrH7cbC
 6MDJOQraa3TtyfIqcIc1UbDmJElYgNLBbSA5MI46xQeMVC395S5pprCkFMxZYLdvNyqZ
 OCNsS6WAZDXkNjmLn+q5xGkoJJvI9BLH+MVqoqwWHYBs8fKGfo2+z3g1d/FPUbA5cH2r
 R4Tz00vlw98w1IQZntuD4xj8e+Xk5KdZDpO8c0fEbxnOIWv9GBGs4j0x3eKWsbfVM6kC
 OZPxBGfMEFPRj5/SwOF1A4GzjQy0SFyrye8aNh1aMFG3mvsrj7mKNkCqIzb7AmpCTpu7 Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8mdbg7y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 07:29:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18N7ErEf058655;
        Thu, 23 Sep 2021 07:29:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3b7q5bt7rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 07:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRoDP+QaIcxMPrhdauyuIMi6huPpUhz5/I4ernxlmIFmbdBaCKvimBZ18/ImzD1/MPwbSZTpCFgXQRZu882j0OUOu71C4zI1KKkT2Qa0bPpDQaJo3zuTFh5FWaQZInhOcDjP98t57DtfaSBgZPKZtbyeUxovaZfLhdeGWBLxxFDTVG7UkXqfLqsq/qmq1O9lJKvw+9z+8DjHRWPbBMosy5YKrR7rsZ7I7Ic+LXj7ygWurFl/H7hr332TSRwISlhzXVM5TtqylQlgBV2AU5zI5vlBgQSWCLTjvtdf3KnnZxo+MXbTUnlWTBnWrbagkvL4ykwoWiqdkezOHeViEGhzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vIkZ5qBAcqAZM3SHxcSjT/eHfz+b8nDiEmOYjfE48ik=;
 b=kVF0F61UdGtAVx75P2h51G4frp2/0zWHL9AYSrz5IOA/WEE+mi4kDWifhWGVU3l15HqHsCuAVX3FaM0ZfAS6iEvn2FCunkNq3es1NFMnVjsOTaQNmDq4N+4l65khY0Nmu1COGyEpyXmCdRy64dL0TX69TJMfY8zMZ3VyenzngVCMXkoKQQ7mcb2G2a669ujlsIi2ugrxfj55MYIi6puhEOMbt64FdMVmSx31x865GSmUuy79e2K24CTF88ve0pJxl+7IZl8lr9X5wI9dCinLYfXq+sCwWBBkGSjMWZZ7SfQmD0gZff6D2Qw9FTwJszz92IWa+psrGkU51hpkFpoWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIkZ5qBAcqAZM3SHxcSjT/eHfz+b8nDiEmOYjfE48ik=;
 b=psnnH2+GucUkN5CHUh2jqHpethdnevf9Id9VejgsZWARhdCuNRUVe0xruw7CXqUlDSmlSChAdMVkqRc3bEiEHQrCo9ESloaO84rx1Kp1lfXiG54qeYnkzHBmdst+Ff8PlQP73xwzyTTdU4ypSvPugobKnlPGSTT7ORoxwzBRFnw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1886.namprd10.prod.outlook.com
 (2603:10b6:300:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 07:29:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Thu, 23 Sep 2021
 07:29:47 +0000
Date:   Thu, 23 Sep 2021 10:29:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] staging: r8188eu: remove dead code from
 rtl8188e_rf6052.c
Message-ID: <20210923072929.GA2048@kadam>
References: <20210921194658.10654-1-straube.linux@gmail.com>
 <20210921194658.10654-7-straube.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921194658.10654-7-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 07:29:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85fcfda9-0ba8-455d-13f3-08d97e63ebc9
X-MS-TrafficTypeDiagnostic: MWHPR10MB1886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1886505625261840EB2E0A468EA39@MWHPR10MB1886.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCEha0fFPUSbkF1ZiyFl/mWSPkt3RXyA01DbGEbZ8UNOKzA3QInM8H2iyt542Bj09IyJwAzceg6fqbDP2cfwHy5t/5/YAjstzNSERK0AUT3I2NSkYF54PTEdDtc6sxe+c+pkoX0KiTjChu/kpYdJGi2QXLum87rSG+RWwv+C1TilVndTruxaUTPjS9cSjIMJplkPp+iOTjmFGRqsfp0OcrQVsE6+z21ZA7m4pc1x68Aw6k/YAjV0fOkFfOAjnXXEd3TEp/y3cElpZHEZ20duYkTo0xmPsohtB32Wb8EIJ1iBlFC+vQpiDAMqB3yVXl3FDb8F85qho5k+DCOUxX//XNSLA3eNMzklNg/Zt3byvvFfA0U1tY92O6BQkDzrfK9X8PQKsZPNm07T/Mk8YUWHEStYyBKCqyMBoxZpz3T6hOP3aMkfPSQWuTAGrN2/XgSFGTqbeoGDmob8Qk5OCZrUbHzUBxtUfnTzUjtDDEZbp8d838wLMgKLqY2fL0WLG4QK0ISjYvSzIUr6Y2tf/kZFiPnrWWPdf5YS9SXZndz4hJFXkSeU+LTEn7/hKLYx6BfM9EaaEAz0PU30kvgzsP1oK+tIgf575ojWoEtS0yBp2Kc+qut4ds1Zh4FTdyW150FIfV4Kd3KleX1IPpn8Q1duITPJeBFzV/GdzkDeOuTuSImpk1WBduU1nKdhD/pTPFuvjM2n7yTcIb2Altw3FASEUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(316002)(55016002)(33656002)(9686003)(66946007)(5660300002)(9576002)(8936002)(52116002)(66476007)(66556008)(6496006)(83380400001)(956004)(8676002)(186003)(26005)(4326008)(508600001)(38100700002)(38350700002)(33716001)(2906002)(44832011)(1076003)(6666004)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EcwlAIDVEp+M1dfavDivu5MwrhQjh92938OqRnE4mfV8Omiyh2e7B9gBI7Qi?=
 =?us-ascii?Q?xtgWC1DASOzpoegP7Cph5KS1Kw3xVMMUAmAVnO8DHk6eN31JygOC6HZbUIzT?=
 =?us-ascii?Q?ewARCd7Eu/82cvhMKIl6V1YRaCmKcAnFX3+yuCfGhf1XWuRYnGVBxfEXKXdx?=
 =?us-ascii?Q?b9D+8mnCYv2t/M/8R540v3jDydVbR1xoY8qXspuqinaWz5unvgcT29GF7/xw?=
 =?us-ascii?Q?xuq7+sWBv1weV//WH3t6N/5LlEb89xk30ZJ5w41z3mtQk85X+6zTtNCZWhrI?=
 =?us-ascii?Q?FwhwnMqBt00Rssk1Sh0AaMYhwsbUkiziaPy6U73j8/Z0/2XpX819slRtpIBh?=
 =?us-ascii?Q?Q+KJRUYHoJWeppuB61t1/aaaD1o0sEtR1iVo8QRSFhX0Lx+FN7GfeVoALCZd?=
 =?us-ascii?Q?8BDuXo4XeTnjr96YhrOHbJu09RY5t82HkUCqP+3Q82LHVKUkQ6qtJdZFHmdy?=
 =?us-ascii?Q?HLHnDJFPGHUK4nNS/wW4yRMNIcO9snMqmAHOUyXBg3t/EMWjGe+m7Sq7299s?=
 =?us-ascii?Q?sH1bpPwK5pD8r+AG0aSXtnEPS6BXazgzKPsQMN8sLjP0pZVc5L6fVWM1x1o8?=
 =?us-ascii?Q?cd8nykBif8m4/B0V3yCOxMb1HWN3TlRXch/4p2ghdezr5DDsELsV4DJpcSi1?=
 =?us-ascii?Q?JEeEpHl6iD4I0InUP3h0kLWofKfQ0mMXzKfMUglLP/AfQfbyFpX+R7xkP+Cu?=
 =?us-ascii?Q?zbP09acBOuPwiiIfc34WZ/0/Q5UEMRiEAhW+IAVIqEVxfvWCMOaOTUV4O2XZ?=
 =?us-ascii?Q?uFdxBtP/+5aCDD4cnmBXY3toC68IhpeKj58r5VKghs6n5vtOv7Vz8bjZXKyE?=
 =?us-ascii?Q?MKE5Kb2MYnJlhzWHoyaY/OKegljaQtWswyc212wJNsTeuWO22f5Ir8Eu/ihY?=
 =?us-ascii?Q?/FGiKrC/jCxS7Ccj/NfzNBZ/FmfDKJTLlE7nhIK2LAQdkkd73EAoGgmh+FRc?=
 =?us-ascii?Q?qYHC4ACD4aPH73VLVTovqU5FaUi2oWblHBCebpipFjidCSjDtXfm+UhC/A0a?=
 =?us-ascii?Q?AOhhIxpF8CtI8Ao+sycdUWHH8GU52seQeQfDQDYXk2kMqVigA2TpQB648Pxo?=
 =?us-ascii?Q?MgDP+itG0JJiX/kcixahsP+P85O6sLTpczYXWyyLTXdcYQa+RuIRiZXl9IFg?=
 =?us-ascii?Q?79WFvaXaayy9i2XeiZ3VwuLdfHq5BMcnSNmlDmFjJUALE0vGEFzCprz2okyh?=
 =?us-ascii?Q?lwkLGRIAf09gemjX1BipNpbeyJBfAXl/83u9c3Hb3ulRLf0qb4oNBkOXLAsi?=
 =?us-ascii?Q?D5MRJsIdoB6cOoEWdRgRalVDyeSljYgU/bSg4XkNqUevy9g0Q5pawx6BUhgZ?=
 =?us-ascii?Q?kvD7mPVG80IXkSJCPXQsHAre?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fcfda9-0ba8-455d-13f3-08d97e63ebc9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 07:29:47.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HpEZJFIufb70XRc/dvv+RD06wGePegadUV/eNxRjqPE6266Q4zGH76DuzZXdBQ5D7JceGxYpAl4HSIeoUbFXXfxOyNSjDPnXqpII2SnfpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1886
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230044
X-Proofpoint-ORIG-GUID: kAs7VAfktAznNyh_ee4NKZ_wmCCNCE0s
X-Proofpoint-GUID: kAs7VAfktAznNyh_ee4NKZ_wmCCNCE0s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:46:56PM +0200, Michael Straube wrote:
> In this driver DynamicTxHighPowerLvl is set to TxHighPwrLevel_Normal
> and never changed. In the file rtl8188e_rf6052.c there are some if
> statements that check DynamicTxHighPowerLvl for other values than
> TxHighPwrLevel_Normal. The code in the if blocks is never executed.
> Remove the dead code.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 57 +++++--------------
>  1 file changed, 14 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> index edaa9a6dfdb1..946a1b97d96f 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> @@ -85,7 +85,6 @@ rtl8188e_PHY_RF6052SetCckTxPower(
>  		u8 *pPowerlevel)
>  {
>  	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
> -	struct dm_priv *pdmpriv = &pHalData->dmpriv;
>  	struct mlme_ext_priv *pmlmeext = &Adapter->mlmeextpriv;
>  	u32 TxAGC[2] = {0, 0}, tmpval = 0, pwrtrac_value;
>  	bool TurboScanOff = false;
> @@ -112,34 +111,19 @@ rtl8188e_PHY_RF6052SetCckTxPower(
>  			}
>  		}
>  	} else {
> -		/* Driver dynamic Tx power shall not affect Tx power.
> -		 * It shall be determined by power training mechanism.
> -i		 *  Currently, we cannot fully disable driver dynamic
   ^

You're a vimster.  :)

regards,
dan carpenter

