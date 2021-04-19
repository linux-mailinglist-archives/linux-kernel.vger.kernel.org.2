Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD3364810
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhDSQRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:17:30 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:13046 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238717AbhDSQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:17:14 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JGEEHu017585;
        Mon, 19 Apr 2021 16:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=8KlEMO39OF7ebH90qpF3okpYg4EhWNZmfcZHUM8dITU=;
 b=l+6ODID1iN89VHz06vVhHRsK7LjvJ+p4Sg865r5X58f4kqHMaFki6Mw7UypwF9mq1T+T
 /n8vV2xEHxO+M+ORJWgbIfddNNxSh/P9IkcFHE5qe/s0d+3Bgss4ME+38fRhNCbpRot6
 X4WZYCxAozXyFJUEy1c2LaSiTQeYEoMG0ii2wfzLEYxpqFlaBBil1+dCBbOByfjFXX83
 epEBXcKR41IkxuGXHgFy6zhq09y22jdBkJ8vGFRIzPp+a7SnlkO3c2GBeVjAek5/q1Yw
 QBeX71rY6PQv10RFRBPHwtylaZ2QGvrU7iA7oi0Asp8rwKssaVJFOQN72g4V+AwRy5h7 ZA== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 3814h8cre6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 16:16:21 +0000
Received: from G4W9119.americas.hpqcorp.net (g4w9119.houston.hp.com [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 4457981;
        Mon, 19 Apr 2021 16:16:20 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 16:16:20 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 19 Apr 2021 16:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNodnjncpCVoQqWgF9JysRpaBDQYg+N6mqIbpOA4QOoAJzGSUdy8MJk0oItrHePBZ69KhU0PFr+meG7kOFEbI3omP8dtA3Zvvl8XWh7rgQBOenq28vuHqk7HjM0oojcundoTlJBA2F73Di6ab42aFNMeaKRgdjKGPWVeJQYGN1G93nqfEKjB9DMxEQ0qhXCmSMq1FMGb32ZXTgWEilmaHIalfhuHGsGcCunPt5v0b+Vw4vGF89/VH56ZoDr5uQIef5xGBsk4Gvz9Gnm9c+Ws80lvcCb61kZcDxPVVHDBH16d61mDWUA3rUyHMMP2RqZJ4kQSam9dBher9aUly3ZFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KlEMO39OF7ebH90qpF3okpYg4EhWNZmfcZHUM8dITU=;
 b=Y8Ewth6d+/iTEN/SgGYnlo9pE+qAFipyJJHRyoenpiGliY3TdNQMY7fcJXDcJAHDDXgdX6JpKHtKfHMIvoMM3l+7nnXmHuUHRagXHe1i/fefzJQ0f3tTFp6Qa8vLIY3he8SYvT1OqNudyY91TzE6NfHJED2BIOo57if7IRcxhFnj/JX05FWE7q5QxyFZXrlTUQ9yoIUycpfnWh0Ik764lj2uzcp9q6R9XTDSCHmM7jKqSVo3JFYbWxQLvnrdZDFD6tk0qC7REmhAQv4FZ6jUdu/ojCBoSxjx3dDesKIpf9MlBcGZWb5rOkiLfgq/X9RDrOJ6PWFsTWvGUGh9IUc9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Authentication-Results: hpe.com; dkim=none (message not signed)
 header.d=none;hpe.com; dmarc=none action=none header.from=hpe.com;
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7715::8) by TU4PR8401MB1215.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7711::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 16:16:18 +0000
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f8fa:ed0b:3e6f:dd00]) by TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f8fa:ed0b:3e6f:dd00%10]) with mapi id 15.20.4042.024; Mon, 19 Apr
 2021 16:16:18 +0000
Subject: Re: [PATCH] Fix set apic mode from x2apic enabled bit patch
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>, <x86@kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        <linux-kernel@vger.kernel.org>
References: <20210415220626.223955-1-mike.travis@hpe.com>
 <87k0p0sfhq.ffs@nanos.tec.linutronix.de>
 <87h7k4se1v.ffs@nanos.tec.linutronix.de>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <4c45a90b-86e6-201c-bd7a-746c2e79d4d7@hpe.com>
Date:   Mon, 19 Apr 2021 09:16:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <87h7k4se1v.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [73.222.225.80]
X-ClientProxiedBy: SN4PR0401CA0037.namprd04.prod.outlook.com
 (2603:10b6:803:2a::23) To TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7715::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.157] (73.222.225.80) by SN4PR0401CA0037.namprd04.prod.outlook.com (2603:10b6:803:2a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 16:16:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d7f41a-d049-4e3d-c8bf-08d9034e7689
X-MS-TrafficTypeDiagnostic: TU4PR8401MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <TU4PR8401MB12150EAE09ED447617E34357E7499@TU4PR8401MB1215.NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOtoES9zARF6sjMztJe2sTA1kO5a0ODzbf3kbu/rhI37YvlEtF4h3nJWRNGeaoS/9TBDBTUl+EtkUMBcdU12syywHELrf18azCwhyUMpU7kuq8Gz6u6KhqcbeXBBLmX7qiRMaA2c5SmuT3urqet0ad/xcab/lZeI2V9pBVP+bZNwi04pEIkjZNI4kH7A5u1B6QbOZkSBtR+r6DTRSTdwLFM1khj6YASA8jL6qm+UzEPDE7kng5FGkzcFbq/WPLOFnlo+IKkkcb9AGwY9eWx9QghtGGAPIBuTYcf/eNHkgypeXOSBKHlIgw6t5qZhFvFcaU1zI3jGGUIrBMIa5U0D8YH8dhbEkfIaav3tsCt0gY9p+2v1FRkrKBDC3r+9Cqh+EF9D6c2HumCSwa2J/wF84ID7gHO1JFUaCkOB7cyMYkqyS2k25wzL4e6LWjRo0ELHdPPn6NTGL1Ida06W6VbRKBWsArLO5EiyIytYF+udR6cM9YRblWFYi8H7rGNhXLd/J/mWSrZDgXydsLNMXhHHT8lxrHqKulByw6XR5JA+DPwcmegqJ4RfdvEx3YvEQOIdXKVKdi0ZXDsTkcUUZr3KIYaeiLgRN5VeufG3IbPQ9qOXp4nNu+0y30qsMCvP6cqKQQm3OxzIYQ0ursh6ulflnZELJdUuJ3B9m7rroDaDGBR7GGubCQhnlk04Nd5HY8+f1K9Vnpb2LetbMlyzCBpOHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(366004)(39860400002)(26005)(36756003)(4326008)(16576012)(54906003)(38100700002)(478600001)(8936002)(6486002)(8676002)(956004)(2616005)(86362001)(52116002)(186003)(38350700002)(44832011)(6666004)(31696002)(53546011)(316002)(2906002)(66946007)(5660300002)(83380400001)(31686004)(66556008)(66476007)(16526019)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?UXW8OT/E/tDA4gZTVmvVDW0zeXoAtDmXiKtgY0VJD6WNXAFiVf4D2jCT?=
 =?Windows-1252?Q?+B4SaL4NDizK20/um2rbnXoPD4Rsmg899+LJR2R4QS4Q7M3Sz6SmX6uk?=
 =?Windows-1252?Q?x8X+KzvXQKF6qBDuDj8b15seIo4xpTbhd0U9UNvRZlgjMoZLTHqjl7oE?=
 =?Windows-1252?Q?tRWcB6HZzjDOeixJM17zpWB/BNQAYHbtmNrBmCKaEsmETDCbSmuXslgD?=
 =?Windows-1252?Q?2qT2l4mePAu6gHzmdfFRN1ZTtQpY+5Dkmu+nsYuZnUH70Dkx9xRRkc+k?=
 =?Windows-1252?Q?dEc5ixJ1tWMTKBXNvd40O+JgRuIcE+OrPUv7fOvqk3HdudWQ7gUMsREV?=
 =?Windows-1252?Q?ChdhE/3S1xl38g8p06zYWrhQPZMkhOie4FcMuKFb/dNd+f922Tka47zG?=
 =?Windows-1252?Q?D9QfB6TMv7U/Fi1f5EYj1hwDh4Ks+4VChv53P3I9+L/XYqectkIOTDoE?=
 =?Windows-1252?Q?mPlSYC2KKTw9P2tN1q7OWyo1Gu6hd1Ye46IZNDQC/lba1ybJYh9DI5LO?=
 =?Windows-1252?Q?Q5F1SNCcTFxxNoy54A5s2htqFr3GZHLMb8Qtdk8KucG9V8ZoTdeZq0Z0?=
 =?Windows-1252?Q?4V121UzmEGYZbbg2wXLCjBXdSaRQrTXKU40U60mxN1HnMxJ9G/wLhKD9?=
 =?Windows-1252?Q?iGLABgiz7RDDrjcjLuuexCsN08dVksWEsXXsN3TVoBwCyIZpJErBzLba?=
 =?Windows-1252?Q?eXiOiTdOaRYJvvvT3oThWiVZzexEXsQPDIoW0rrJeurG9r+IhCGoLSHt?=
 =?Windows-1252?Q?4v/CT/+zJktmdea4qotGF22pNOKoiMhICyIJqKtStjNL0Z1zNXNDqovK?=
 =?Windows-1252?Q?oKsSAs68iK2KxD6vetUeAEn7CiH03OR8N2ibuvl6AZP5TA6nQrlvOCbn?=
 =?Windows-1252?Q?lqaklbdtUtasCeVGmtDCM27tjiLXzcMmM64pM7hTm/vD5XxXnIcvV7BE?=
 =?Windows-1252?Q?bUswNw8dtJtzlfBlkwLDrI2eeTlNG1DfFjQj8tTLOfHTg+GVH5Osdw9t?=
 =?Windows-1252?Q?djg+v54r5zie72gPxoLutvc1J1FopPQsGaypKXpNv9J81eYcUJJn+05m?=
 =?Windows-1252?Q?Jf8yKnogap8uRCkdTyvmcz/VNz5YSwupdFa6Qbs2Gcf0RdGvSdkF1KZ6?=
 =?Windows-1252?Q?hB7TGnHzah3wKb4ns2EHBzCObYh+gSwH5yWsj54Lf5MwkbMsorZhts0J?=
 =?Windows-1252?Q?YedSGf+o3U+MDoelanC1J0DJX8bCWnImynRcSHLIUCBYJq9ZeonQzKaC?=
 =?Windows-1252?Q?csdwvJNlfy4axzgfaR4+LWV3HfRn21MQoc5pSpyyPdqqiRJX/P4Fo/OS?=
 =?Windows-1252?Q?XTt95RLvyfoSHJPfHcKuG8KeXL74hLeVe/UBE2/zJnwC/ZB4uMqG1d1w?=
 =?Windows-1252?Q?m/A3JYveB9DpaR88vRduUyoONPiqT9keAUQ2QTOR24xAlrZ+UbdUBwXO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d7f41a-d049-4e3d-c8bf-08d9034e7689
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 16:16:18.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWLw3EcAR9HA1BInxCAS08MASu89EUcANFd72duXxGE9dhyrF4dJlwyRwfqP1tG8qMUW7Tuwt1qIdomRKaTHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1215
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: rx8NSA28RDU0Umy4ULOUdUmxGL-Z64Sb
X-Proofpoint-GUID: rx8NSA28RDU0Umy4ULOUdUmxGL-Z64Sb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for pointing that out, though Boris did highlight the same 
problem.  I still do all the patches in quilt but I've created an 
automated conversion to take those patch(es) and use git send mail to 
send them upstream.  The platform information used to be included but 
it's not now and I hadn't noticed that.  I will look at the tool 
particularly the git format patch step.

Thanks again for accepting the patch as is.  And I will be more 
descriptive in the patch and in code comments.  I do get into the 
mindset that no one else really cares about how UV works but it sounds 
like I'm mistaken, at least in regards to how it affects the kernel.

Thanks,
Mike

On 4/17/2021 4:10 PM, Thomas Gleixner wrote:
> Mike!
> 
> On Sun, Apr 18 2021 at 00:39, Thomas Gleixner wrote:
>> If you can't come up with something sensible anytime soon before the
>> merge window opens then I'm simply going to revert 41e2da9b5e67 and you
>> can try again for the next cycle.
> 
> so I just figured out that Boris wasted his time once more to fix that
> up and redo the commit in question.
> 
> Won't happen again.
> 
> Thanks,
> 
>          tglx
> 
