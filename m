Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5DB4288C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhJKIb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:31:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16614 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234910AbhJKIbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:31:25 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B7RvEu010266;
        Mon, 11 Oct 2021 08:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DMg1YZNjKdf4VfCTioXhsghmXvGWKwFvslSxWts5nRA=;
 b=xbSFOooEf5EfAOgw5o3QfnhDy/lxJVQQ49hQ9k70RsZRHx/TDc9RsJA4Qrjv6+N5Ov3s
 bxUk+sDJw8b62mhtBn/1+xB9afRQsbb72yTnsgIx4GkP3YvrccKxthj5+V+xw6dVDMPx
 Ia463Nr1eZ09NnP0uwdR7SNVNCZDTfoufjeqRLZSOly7RmqNge7dhPgvYYzST980X+Gz
 B6SiiEkWJF6YIjPVml/mt/kWwYUuseb8Y14mD5MfWo6JSkI4bhOO3yV+fO0PXIvpitW2
 SUIQgu9j5dQbrmvfNcNLvBAU3hxrhWakYEr8n+5fIrcxyjEJu7Tc/QmmgUzn3LaNYzFW QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkw3j2qhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 08:29:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19B8GJOi080223;
        Mon, 11 Oct 2021 08:29:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 3bkyxpk1ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 08:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx6jF25sNhbfMZDZ0gmkEVV01l2q3HP9YYC9SAdvQoTR2tX2rO4DD+/WhzJaF64R4/aMxt2qWvB+NXlQSjKloRom8nmIpm7mGutzPz9VjaJEQEC5wj6d+Asihatxxkhlm3YmbhWzPjOzPSp8W9m5A/b+ZREC98jPmmxYoNuhkFEzebbTt5Xi31rvcPk97Br6aWmY4uHLOF7vCqlNkYizXPuU1xOivabxjRelMx9BnLbG9sgArMna8hJ1rolRp0ohrmwCDpPZgotfqqKlNSgwYsNFs/NbVtYo1bPHocIOXw3LLTbDuXFfxUvqARN5jYnqt53Fho2lbOKh0CPRxpijyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMg1YZNjKdf4VfCTioXhsghmXvGWKwFvslSxWts5nRA=;
 b=eSzkIOWGG8klc/yO3jc2/lYatLqEq6L36h2S7yfsp8sVgynXO06WVlCnd/LEl7fQyjzkM/eP71uPwCETxdKjtCgkostawiGq3RwgcmTna9KGAwoa1Jig2MZ7xUgugqSQFe2S43s8D6NDVZxk4R9dwyWKrG84Cgz3WB7I8sk2xDGZr7tMob3KjgfdMGVpXl/PpfOoR73wYl5j/hlQqz4k4lsZyfdeN5APOCXhij8b62fHUNvhLMOCHjqwhq4DOmCjXqSMzboPlacZZlrFYpSaOcXS0fNLGHgmJEgQyXXEdECvrrhrrntof+rdxb5NL3+77jfmHcddDxydC3UmVjXJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMg1YZNjKdf4VfCTioXhsghmXvGWKwFvslSxWts5nRA=;
 b=J1s+vPbdqhfQNTVwTvw5MTA3YoSiZ8mGsoCPve2Xiy29Rk6trKoQuf3EsO/nLsLi8n5OM4LiqpZ7zIjaUYLGhx0SPKIsY1+Pn8Ku5ir+DMku1siesjdXqJpVegCZNJsg4lGyr4VfAs2qde7QFipPdJMAyoaQxHjzEvKxOAI/e/I=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4449.namprd10.prod.outlook.com
 (2603:10b6:303:9d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 08:29:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:29:14 +0000
Date:   Mon, 11 Oct 2021 11:28:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Provide a TODO file for this driver
Message-ID: <20211011082857.GN2083@kadam>
References: <20210826130342.9552-1-fmdefrancesco@gmail.com>
 <20210826135413.GA1931@kadam>
 <6435467.SEsBC3EFVD@localhost.localdomain>
 <2664974.42EkL7omyK@localhost.localdomain>
 <20211011082134.GM2083@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011082134.GM2083@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 11 Oct 2021 08:29:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3561a68d-eec3-44c6-911b-08d98c913594
X-MS-TrafficTypeDiagnostic: CO1PR10MB4449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44495EB8F31CFD90D24F873F8EB59@CO1PR10MB4449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKkPA13b8c6HK6FPdwVBYgOxbcocRRbsJ7vB67DdNLPDzsvrn1azx/rqwYcWapKsNm3sx2yDpqc0y2olwJ+UBnDggnhYZCYJSGcl5Sk4PGuxmV3Agoqd+60WbRqUmc+6z0yA9Fl/wKj5OdDFe1lhy9hVkQku16SrmOeGh6M84sLYglgfep2mLpIVt7XAwscyQBR1v8ccq4PjBJD0X9cNGFyizDNNbxfDsGA2rcO4+fT13BhcxUozdGkmKUvG/rDxpr3vLnoKQ6uhRFcPkfTaCsgRMNJtVw7fK/AVobC+omEZclHXme8bnVWAZ2tjo1IR2DF/xw8lN83fzJktbafv/pTVqrzyIFMT326q12KcSwup0uXq/HS6N+hA9HCXFUfBPW2sRsuTgJbLt6X77nuuosk+SXRdAf37+uyUuxuucl3ZzOGLYvNMzMn/OM7SjNWh2rHverrRlXkuEurc+dNt6wJcUCsrTV9HEbgMn1eM+OmqqHD4ZcWSGggHBa1GFVlWBKXa5th9rwEjS+prwQMkct42BzJFxvF4BUBIiwgopNZTJHUDVPgwj92BPQOuIDfuQFs4PJaUNWASyuBA+uHWC9BYb4IQaOq0nJeg0mmpKSrv/h8S4HFowGM8d2KjawDWg09R4Q4yKsSXIg878fJ70WNJ2dzOxtla0ZJh+Im5tdQ+n/Pq+LZz8RBZr1w9lMYy7gVYbD7VCUEJ2zozAm6J+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(4326008)(52116002)(44832011)(66476007)(508600001)(33656002)(6916009)(38350700002)(38100700002)(9576002)(33716001)(2906002)(66946007)(1076003)(6496006)(66556008)(83380400001)(5660300002)(8936002)(55016002)(9686003)(86362001)(8676002)(6666004)(26005)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBr5bw3caAiZT+7KQ8qkeb3cTw9sCoeLPuxN3f21/0bGZPOR8hyGjDiIXkJm?=
 =?us-ascii?Q?F5N/GwwFg/grLBr4a565XxOVY3WBkWHwV6h/Hh4j6sz9VYP6Bvyen84rZ2Wo?=
 =?us-ascii?Q?j6N2o6llSY+z+5XBQWC2xW1EZZ6Z1TqP9A7CxfIPWhcJjITqUiKC+si3Map5?=
 =?us-ascii?Q?hzoqNlM1+TGe32b3f/dC8KEMcF/fbn3RFCfyDXNg5Alg98cS4dcu1wNYFeJW?=
 =?us-ascii?Q?ebMtov/IJMAMcyh0b1wvuG1zf2+lZENYTPGQxNfKXOOynMdsRRV/wtTLlLHz?=
 =?us-ascii?Q?3CKMcrEYfWD6L8ZPUqkXUK8wu8bzDw5K2pm2s2Dh20/Ss/iFtatsH01owQW8?=
 =?us-ascii?Q?j4sUAE69aJauYoMM8V1nksNdYBOmM7AxrHqjBfVE5GQ1u2wJCw3XJsRPQ9fZ?=
 =?us-ascii?Q?WU7GDKDoCU+TnGLfRs1qTO90M6CHejjjyQYABDHnoleOuI7nO/VOSr6P13aG?=
 =?us-ascii?Q?8HTZIIaYxcJOTP05PjuHyBJ/eLTIrdmQQAfxjOsBcoHMxm3EAob7L3IofGNe?=
 =?us-ascii?Q?wcQZ59CuKgfCDchVHgUOlbjX4EEfuvbbLAAA3Lr9HEQFykhaEw0ZVp+vDw5a?=
 =?us-ascii?Q?bJtzbBMtVQsZKIq/L3oDtwHTTse05SGE9rqUUj10HKdJJbdyyFEmc28WavVW?=
 =?us-ascii?Q?k5wJLWK858bk/505BWsWbRlC453QvYUdqBvs2+Nvd9EF1WkNn56D416XFYVp?=
 =?us-ascii?Q?zjmSi6OOrRYnqV9fHj6IoTXYt3+/0WJcRIuBCt8K9ba3CpeP34oxUdBSwTwV?=
 =?us-ascii?Q?l+grvngJ6vFkuugtd9Wpv2ahXPIb/+J+DNaEmc+JDhusOAHC4es9alzFKRen?=
 =?us-ascii?Q?myPZzBUa3YdbGHFkSXIEA4XgoJ1fl0oZINpKWnf9wPgtBCzFbi5rJly0nTCl?=
 =?us-ascii?Q?4sV3J6vbUJCSI/UjhkVhfTtPJCVcrOatxtTDDX5FcDeamP67pHq28Ghb856K?=
 =?us-ascii?Q?5BVwrfGU1He9PbE+NmioAXWEKZ6pNVkYMxrGN2Qdl+kVOQz9owM9ylyX3JvP?=
 =?us-ascii?Q?M7RcYMvarKhP7Bc3kdhWQ/rvXzwbg0tPvnyYzduNra5SqMM3VAabYROD/Ge2?=
 =?us-ascii?Q?1oeIjx3Sg7FyMkk4nKTswHksPxcKEuQms7+u/JZa4g+xTHhll10j6tsSSZvc?=
 =?us-ascii?Q?NCPE1+HeoRD/HBZC8DbSABUkwnyNnnUNzL9BvMOT5faFVJTrRRjRy4O+mtEx?=
 =?us-ascii?Q?5nQWBlCkq2zCNF0Sekx3HEjTp+cy+Lpx25pfABAi9tGKY3BjlUpTsDVPMxlC?=
 =?us-ascii?Q?z2QVTsn/S8hPINN4i1Df64sYG2OL3AIRqjMAlImcQDdp5bfY+ALFv84YOqyU?=
 =?us-ascii?Q?7bjgSPxYEe34Io66hlMO9Wkc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3561a68d-eec3-44c6-911b-08d98c913594
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:29:14.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuQvoURnW8pjCU1B1/35o76VyJnEcinZaaWMFQtFCmv/IobTNksBimjN3GtbmD7sj4wH6vGzkZGw0NBo0tEZ4syG80mPDsljR4zjwvCYH/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=984 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110110048
X-Proofpoint-GUID: mgziv4c8jMJqgYuNBdRcOfPUMICHI626
X-Proofpoint-ORIG-GUID: mgziv4c8jMJqgYuNBdRcOfPUMICHI626
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here it the `smdb.py preempt <func>` output for all the r8188eu warnings.
Unfiltered and unchecked.

regards,
dan carpenter

======

drivers/staging/r8188eu/core/rtw_ap.c:1080 ap_free_sta() warn: sleeping in atomic context

OnDeAuth() <- disables preempt
OnDisassoc() <- disables preempt
expire_timeout_chk() <- disables preempt
rtw_wx_set_wap() <- disables preempt
rtw_wx_set_essid() <- disables preempt
-> rtw_set_802_11_infrastructure_mode() <- disables preempt
   -> stop_ap_mode()
      -> rtw_sta_flush() <- disables preempt
rtw_del_sta() <- disables preempt
cfg80211_rtw_del_station() <- disables preempt
ap_control_kickall() <- disables preempt
         -> ap_free_sta()

======

drivers/staging/r8188eu/core/rtw_pwrctrl.c:76 ips_leave() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_pwrctrl.c:78 ips_leave() warn: sleeping in atomic context

rtw_set_802_11_disassociate() <- disables preempt
-> _rtw_pwr_wakeup()
   -> LeaveAllPowerSaveMode()
_rtw_pwr_wakeup() <duplicate>
      -> ips_leave()

======

drivers/staging/r8188eu/core/rtw_mlme.c:1602 rtw_set_key() warn: sleeping in atomic context

rtw_set_802_11_disassociate() <- disables preempt
-> _rtw_pwr_wakeup()
   -> LeaveAllPowerSaveMode()
_rtw_pwr_wakeup() <duplicate>
      -> ips_leave()
         -> _ips_leave()
ips_leave() <duplicate>
            -> rtw_ips_pwr_up()
               -> ips_netdrv_open()
                  -> rtw_hal_init()
                     -> rtw_sec_restore_wep_key()
ips_leave() <duplicate>
                        -> rtw_set_key()

======

drivers/staging/r8188eu/core/rtw_mlme_ext.c:6540 receive_disconnect() warn: sleeping in atomic context

rtw_surveydone_event_callback() <- disables preempt
-> receive_disconnect()

======

drivers/staging/r8188eu/core/rtw_mlme_ext.c:6859 report_del_sta_event() warn: sleeping in atomic context

rtw_surveydone_event_callback() <- disables preempt
-> receive_disconnect()
OnDeAuth() <- disables preempt
OnDisassoc() <- disables preempt
expire_timeout_chk() <- disables preempt
rtw_wx_set_wap() <- disables preempt
rtw_wx_set_essid() <- disables preempt
-> rtw_set_802_11_infrastructure_mode() <- disables preempt
   -> stop_ap_mode()
      -> rtw_sta_flush() <- disables preempt
rtw_del_sta() <- disables preempt
cfg80211_rtw_del_station() <- disables preempt
ap_control_kickall() <- disables preempt
         -> ap_free_sta()
            -> report_del_sta_event()

======

drivers/staging/r8188eu/os_dep/mlme_linux.c:115 rtw_report_sec_ie() warn: sleeping in atomic context

rtw_set_802_11_ssid() <- disables preempt
rtw_set_802_11_connect() <- disables preempt
_rtw_join_timeout_handler() <- disables preempt
rtw_stadel_event_callback() <- disables preempt
rtw_roaming() <- disables preempt
-> _rtw_roaming()
rtw_set_802_11_bssid() <- disables preempt
   -> rtw_do_join()
rtw_surveydone_event_callback() <- disables preempt
      -> rtw_select_and_join_from_scanned_queue() <- disables preempt
         -> rtw_joinbss_cmd()
            -> rtw_restruct_sec_ie()
               -> rtw_report_sec_ie()

======
