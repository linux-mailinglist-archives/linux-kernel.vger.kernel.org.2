Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7718F3F5891
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhHXG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:59:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48494 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230332AbhHXG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:59:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O6uoZW013531;
        Tue, 24 Aug 2021 06:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=MwF7jtItQaLJsG2Gj24TrT4V58zAkHRJQ3cR5+omk48=;
 b=L9l9a2/q5gGQujfwAGT36oaRbjYSjoNPhZvbBb7mXNOZDzEhZFfzzhvT2+//bBQq5Q1g
 twFs3KDugSQnvA/DyaivlZ+VxLdmtxXy/Hp3KrZCEIiAr+wv0njEwPi+w7/c/AUknJhL
 SLQiJ0ji87uKDztUqfPuFW1It7Me0v4Qsd3v5TOkrVy2Tja+Z8y/fGj65rhLyrgkDmF8
 GQVJKibheM3fu1c88hQpHwfPdsSBX+r1ft24KoXjsAy0TL36X0u5jfsSKZZvDdhQ8Ppg
 p/invokytiKXIky0hNfMsjPqegHMyq5fbpYMxrK+tPxvsXK8qG5pewFnYiDy9qcBRYCj 6w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=MwF7jtItQaLJsG2Gj24TrT4V58zAkHRJQ3cR5+omk48=;
 b=v8K5mBxsa4mJTcfSaINjyAhTOlw92jdIaghVbSA24MzjTXXEuAD5PmlRR6oZ9SaC4CG4
 TXbFw3M0RLkzmiruw1FTlCEjTNmDIUyIhp/D7oYFkyixvRs4r5KbC2BagAlmOIlW8Gb3
 /EM4OqDgsniUoxIwFXxmefDwNBTEKXKNl7auVwbgTK5u+cJP9blZyHiALF7coCNg3J9q
 sB3xkX5c8zJ54n2gqNxEdfu2+T0u650lgtmU77hKtu1nIfLm/Gi4+UAm9leOQ9Rf0GA8
 uYZyNF/Gt4I+levd5Q2HW+JwLwfInpEj0UA0BK6FJmAI+yMOZJ5beHm4bgLxV90o3BNs Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akxrebc54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 06:58:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O6jU7Z148925;
        Tue, 24 Aug 2021 06:58:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3030.oracle.com with ESMTP id 3ajpkwqx5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 06:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIcY0dJ9xYEY1ALi1fEw3GiklcWXB27vAKXZFGTFRsia0o6IdygOmiUaI3nUYXr9nu6RUEXNQEFToLfx0CYZjvg1umtTCqF+AjvO4qB3minA3XEIChDKUq2Oudk+DEMhuNKZZuGKzBDVbSSlheQpIsp4m6VqcUcQJttkKo9al1ymsrPCHC7GTJu3NAlamzFmahvi1m2gAIdbfCLtIg/A/kjgYaAGaRxJxOBwAJes4ugTaIf1GuOJRvU0EZ1IfnPwyHSg/RmmHae+/2dw+jnYi1mcltC5juE1acca8LNes0oWRVuhjVQ4k8aE4wjp4pqi0H8qogAs7GcXMBDcA/bJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwF7jtItQaLJsG2Gj24TrT4V58zAkHRJQ3cR5+omk48=;
 b=iTqUK5CsYUuF754xnCtzNah7zh0Yr6NoxN6xmm1t4/0o942YXdHgQw5pO9LeXzQUVCmTVnr4FRy+x3F3FR3VtM98+XUdCHhCffu+Z27XxjZu3f8oUq859rANh2aW8csJQaoOLDxoHilhXfSXK0gYwKX/JkhQEvIs9U0JdEngpnPtCYqPix2YgwUC2SCdbjmZOSSITXwup0HtgK3jrrPBorlgv06kjnjDGfaJwNRi146CnH9MXm99J0Z7hgxeOhLU3cktgJ6gTtkWzeCT8bEPivHvAKcmsb+6XmZYdbY4YBI0dXFt2rVapZNCegdMT7j+czXmqIBuh5QLdjw0mYtrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwF7jtItQaLJsG2Gj24TrT4V58zAkHRJQ3cR5+omk48=;
 b=hoK4ccfBg5J6VpwTe2JvNLrcIjxjsVM7kffhBDrOwFgTDWqXkb3rzItyrvKs5Jyc18rh+MGgU2LubcXlUT62MwzHjPFGWRPpxqU7ld5aCKvhjpZBscHZEuz2xdHcc0ASNzOKBCRF1EPu/FHft5Lgl+GA6wq2zYy+JNGTh0PkSSY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1358.namprd10.prod.outlook.com
 (2603:10b6:300:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 06:58:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 06:58:42 +0000
Date:   Tue, 24 Aug 2021 09:58:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of
 rtw_read32
Message-ID: <20210824065825.GL1931@kadam>
References: <cover.1629642658.git.paskripkin@gmail.com>
 <9004eb2972780455db4cba9694244a2c572abba8.1629642658.git.paskripkin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9004eb2972780455db4cba9694244a2c572abba8.1629642658.git.paskripkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 06:58:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b4824f2-080e-41dd-0b99-08d966cc9bc1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB135839084C3A3B3DFF52044D8EC59@MWHPR10MB1358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFvxR3WSviWKlKxLeGSz37fNSqCMo22k0/0fUTYCG8/8kulNoikwW2NwtjL4dDLbPB3r7JHRcjDPjZJT5afUfPPzfHiGNUrfjI/Bv9tWWH+teGXJIfVFfDRVUum6mrVwaEF5oI+363DYzQXR8S308iSrHcOciCYXZ+IDRHiNptxd2xpH/E2dXKOZVVSSDMAk8OAR8gArtXNQcO8KGl3Til8GfyaFPjP17C5KKS7NiD4Fno6CI/O8O92lp2Mum6RttUiiKhi6E3jVVivMDO/00lfC0Rl1B9JxOEQCkKUfr+iSBjjJHN3ro8OW/l0tmHEboUC1q8AR4iCfZxgyoNaZi9CyFNqZ8OdyVCUd7YIwko+Sch+P7WvAOxonF0uKqYNBWP2yANTqq3jliQtcrBv4LiXeiQGDsmyoui7e++jcgAdYDTzTWAI9u+XtMiRud3kO5WLwiCnrhy/7j+TMPObTQlUgdl3sje1uLUE92jeq37OZ2QGIBXZ22itkVYpHyxStRm4vaB+kEn2BFN1j/P14YdMts1U4Gla86PrTNs7VOxV2g+rTvs2eJS0QlO4/cUkRY2Gbj3MrXoAevN8RgqOcnKF4pLtc9y/mM2Wrl3nzjeS7D+hyx/toFKKTDOq0zyDKD6m7YavJDQs2yGEvjUzZI2vo/Au+GezQUMYUS2oKux+fNcpOnTh450E1UR/Sa9KyBQ/3uuIKP08vLFYivajOSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(9576002)(52116002)(5660300002)(6666004)(6916009)(8676002)(6496006)(2906002)(186003)(66946007)(26005)(86362001)(4326008)(38100700002)(8936002)(66476007)(316002)(55016002)(33656002)(9686003)(956004)(33716001)(38350700002)(66556008)(478600001)(1076003)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ab6j7gxbfKw6Q/2BchwSvmc+iMs4suZZmJ4itYjtjTzd/JBk4NRqyu3Qdif4?=
 =?us-ascii?Q?BDBQ1aRW84ZidFh3SkEOioelg4bRxqBmYri0H8LmQu4GNqcJoJAbJyeOwmmn?=
 =?us-ascii?Q?eQQFLOG/j/ZAmrklVc12KXec4rJKhVcztkf/zEbly77wteHWS2gYrIgjT8we?=
 =?us-ascii?Q?9jcyY+qcejw6EGIVn91BHvn2eesY16iOnsq3O3to159RYUKrYHWaUjV8Ohif?=
 =?us-ascii?Q?c3m0k3mUPwLX7BbVrLOs1EE/52JKV8F7hkIXu7YBruaViKq/uN4VTMRdDmRC?=
 =?us-ascii?Q?QkM8jG8Dkn5z3XE3IRooBmFS4MeQaASa6rJMcwTJnNIGsMpMd9Kpm+AUxwTw?=
 =?us-ascii?Q?IgZU8Wasf/9Wbs4lX+++TFhIGVis40gWwbIm+h29qA8FPj79rXfjZYYcXjxl?=
 =?us-ascii?Q?mvlNndnwod+nC6flslEjDU80s/eFKyxLPFWc1RUJhzvqPjfb1p1FT495p7Fl?=
 =?us-ascii?Q?i7gFu9XsUntg/if8GOWN7Z2gy1dQMMtj8zkurwDBG1tnDCEUV6KAoJkqyZru?=
 =?us-ascii?Q?NTqHe3jGCX9ErEHef6hkdXeV4Zk79DcBRvEipJ9CW3Jiheop4Ry1+8JYca0/?=
 =?us-ascii?Q?etT9zkdpkFkH19ju4wVxCt9zhowON1YKNH53u4eBdJvIYQ8j9u0Yr5e9USSX?=
 =?us-ascii?Q?9mCUt8DIom5J12oYbTsOOKatt174iZxJeLmcOFZ5plR0EiGH+kB5ITNtYQpi?=
 =?us-ascii?Q?9IwcXOuLgS4nMgFJMRXUt5VGXmFqN6Gn2NjFWcDvSIDveycZ2+R/m/148ATD?=
 =?us-ascii?Q?HXdYRnWQgOolzdHQNLlpG7i1rPoX1THQ6S8Y3EW/NtOuFNDjs3sAIQNHULIn?=
 =?us-ascii?Q?VdFYyj/xTiSFn5clNjfpJ9SKq8A7QArwhJx87xiB03gKRyPIXG9/T3VJy8W/?=
 =?us-ascii?Q?sjwP/B81/tUf+waO7g5u/d30463bHYx1TUu4SzUkz4wGXFmmgVcTjb0jq7w7?=
 =?us-ascii?Q?pnNTXkwxVbjh3uam6jvIzftPBWKAoxBX+F2YFDCkn83mhSxtUcdGWP+CBubL?=
 =?us-ascii?Q?eOrTUc6CFkqCTJxae/g4Vh8eqfHyCVhUjXQiJt7L3f2+6kX9i3pHYBTUFxlI?=
 =?us-ascii?Q?3p6bTdX1/SxoRtq2nJeq2SmLMab5RFE9WvXxOni7QGj3m2C70Ivcj1SQ73OT?=
 =?us-ascii?Q?vff040JMvLQOmTB4WuPuzt+gEk0ve9K7GFFHhrcgGJ+SO1FHwGh9UWOoPXeQ?=
 =?us-ascii?Q?chNKb+ylg0dO4JmOibnrYezXn4eUBGyZFe7ZdV2T/aEkiJ0D1/flxMARodo8?=
 =?us-ascii?Q?VILCTdihYeTex2ufFV1ITGRtpEmTULiEZLUfVzznodYWR2WeZTba99/Da4OA?=
 =?us-ascii?Q?5MHR5vACKxlVUOOlo7kws74u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4824f2-080e-41dd-0b99-08d966cc9bc1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 06:58:42.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oDDVnNu+2bHZrs0Z717gZTQUAH5+vghJ21ZfCjTQBLhIZ90PaDo7YJr9f9UmNHOJhihrfj2vUeV5sxQFt96IXieBaWfXqqwSnIzQejy03g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240046
X-Proofpoint-ORIG-GUID: oEXjyeS5qTIXlDdi4JW0Mm4SnjfkP_wO
X-Proofpoint-GUID: oEXjyeS5qTIXlDdi4JW0Mm4SnjfkP_wO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 05:36:01PM +0300, Pavel Skripkin wrote:
> -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
>  {
>  	u8 requesttype;
>  	u16 wvalue;
>  	u16 len;
> -	__le32 data;
> +	int res;
> +	__le32 tmp;
> +
> +	if (WARN_ON(unlikely(!data)))
> +		return -EINVAL;
>  
>  	requesttype = 0x01;/* read_in */
>  
>  	wvalue = (u16)(addr & 0x0000ffff);
>  	len = 4;
>  
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	if (res < 0) {
> +		dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);

Add a return here.  Try to keep the success path and the failure path
as separate as possible.  Try to keep the success path indented at one
tab so the code looks like this:

	success();
	success();
	if (fail)
		handle_failure();
	success();
	success();

Try to deal with exceptions as quickly as possible so that the reader
has less to remember.

> +	} else {
> +		/* Noone cares about positive return value */

Ugh...  That's unfortunate.  We should actually care.  The
usbctrl_vendorreq() has an information leak where it copies len (4)
bytes of data even if usb_control_msg() is not able to read len bytes.

The best fix would be to remove the information leak and make
usbctrl_vendorreq() return zero on success.  In other words something
like:

	status = usb_control_msg();
	if (status < 0)
		return status;
	if (status != len)
		return -EIO;
	status = 0;

> +		*data = le32_to_cpu(tmp);
> +		res = 0;
> +	}
>  
> -	return le32_to_cpu(data);
> +	return res;
>  }

