Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC03B8095
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhF3KIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 06:08:53 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:48438 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234101AbhF3KIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:08:49 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UA4E1l017385;
        Wed, 30 Jun 2021 03:06:14 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-0064b401.pphosted.com with ESMTP id 39g5a80qq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 03:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dputcS/IX6XsmM/clZjmuxIrnqIkDdZrLmWQpuZr+HU/N+UUhvOdXUwL9hz+bYDv4SHiNNpDPMn/MRfoyH0+uhY1b5C25p1ITDkf5ZXCz/++D6y08To11b+j+rukRf42Jloyeg9Hdf+sXyO6P76YzXSdARc1F3mDKQqXwz10zSN5fL7CwOi2F1Gcq44h/p9shJ5K8Kac1dZdGeH5Qc+HRWzazxUUH9E+kOluVNmEQZnJ+Pn62mZ3cRAsyug4vzrMLeKC3Cl6XvRHhC3qLE3guz/pVDeosECFGB2SaLphincgVt6FqbJOGjk51yuuZKLcQmE9l5xvfkq2aPV2uRW57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1riiS8zWUd/9fMZZmOCTEpLFmG4P6XOWDWmH3WIfpY=;
 b=dtApKAcT1uKdYyQXA2G34nQjFBx/bTZc+zss94S43kcol8OpyN1g+GMIgT55EpQKeliK3OO/fbMJjILG0OdVxj7hKDLW6rTbrk4HoMQkZBuDVTu75NELqctSPPANJ+9d0vr4NmuP3p5/ol7PXZiXodhNC6T+17fFiSiSjXgC8W+zawMfEs/XCWIEPs42OZfskVxMxHUMLzC4VibBKtl6rzeQXBXdVTRQjdEqkAVRhGHog/G/4GQMwM14WAYmZ6Oog7/LLdk9j0VObXQ9UDD3NcOw5ane50tG50BCkFvPjl+bsPFfLxJDX0z1FQmw5Y4A5H6vGc6diOellKB1mzl8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1riiS8zWUd/9fMZZmOCTEpLFmG4P6XOWDWmH3WIfpY=;
 b=j9Qj+UTnfgydM60oKZx9594ix0RhDw18tIxnIl4iMIs+t8Fptpb5qnD5pHVdH9xutvArQ+RkXF8QKE2nAQVp2dPxGMRGTJ2o5BZOX6jO3Ro5z+juK/KxozntkX+QoUU8R0CZTw0UErm4do7hMpAzxRQglxaUPULMN7yE3KaxMWI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4252.namprd11.prod.outlook.com (2603:10b6:5:201::26)
 by DM6PR11MB4185.namprd11.prod.outlook.com (2603:10b6:5:195::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Wed, 30 Jun
 2021 10:06:12 +0000
Received: from DM6PR11MB4252.namprd11.prod.outlook.com
 ([fe80::c0f2:cf50:3404:90ac]) by DM6PR11MB4252.namprd11.prod.outlook.com
 ([fe80::c0f2:cf50:3404:90ac%3]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 10:06:12 +0000
Subject: Re: [PATCH] locking/mutex: fix the MUTEX_FLAG_HANDOFF bit is cleared
 unexpected
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     Waiman Long <llong@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210628155155.11623-1-yanfei.xu@windriver.com>
 <e914d4fd-5afc-35f9-c068-7044ceda53dd@redhat.com>
 <02691c73-6ba8-241c-6ec8-486d9d549c23@windriver.com>
 <78f45c3c-191b-bd14-3b38-522907d0e24f@redhat.com>
 <d48fdbae-4b79-9039-4577-d3aaa18d543d@redhat.com>
 <8241576e-ac92-1a0b-b1ad-2372b61759ea@windriver.com>
Message-ID: <945cc291-7057-389c-faf8-a30bde605654@windriver.com>
Date:   Wed, 30 Jun 2021 18:06:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8241576e-ac92-1a0b-b1ad-2372b61759ea@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To DM6PR11MB4252.namprd11.prod.outlook.com
 (2603:10b6:5:201::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BYAPR03CA0017.namprd03.prod.outlook.com (2603:10b6:a02:a8::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 10:06:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a25f235e-d911-46d1-cb5e-08d93baeb04d
X-MS-TrafficTypeDiagnostic: DM6PR11MB4185:
X-Microsoft-Antispam-PRVS: <DM6PR11MB418550DC6FFB703171047D49E4019@DM6PR11MB4185.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yp8SvUAOFSxgyaCwUuSdbYznjrXyKq6uEPFc7yOPG5OWwFKn+Cis4C0BBVBE0vljn0b+zhwNpBNnuLZnH/vV1tduUZnBA9ldl85rcFwPrrUYzlVAgjTtWsQjZzKMOVPS05H520d7oPiY+0AVprb7DBIjp+O3FzaKHqXldOZr9yF7MLpynMQ7HTeSzQD2KsrGfhh70DeJNy19vA19UFGcYcXbY4XzofbOX/w6HDXEIPHMvKneptdVBfqQFyXLF3y3hk+IvmGveAY6FBfF/TYOFDay2ExcvQIKHluKwe6kGS1kh7w7vO4cIuNe//bbpAtJsvZFXonRy78I5cDMv+LBcWQTRotLupd710qClJg+uGg08zoJAn7SvZFyH150+4JX6h89Ou12K39SmBmtb3JfD/FOnYtENF84DyKBLAcYexR7z2mbv9j9qgeKk8RK90n17gr+wNC6ZbQ3sbEnfz9wG2wbqxCpOcKSfrgBV7MOH9X8PURzYXKbQGJnMZGyeJLtjtQG+sd/M/Mprdzp1RkINq/i13FS4dt+8bjAUJOK31G5fMFUFXguS1dq7Mz+4r1q3Oq8n2+niMqEc+T9JuTWQVGKkph3j23uhHRaF7v1ZM9J2meevKAkZp70evaQN30+JiHhcLhS+gkqfZHms56ZgPfi2Aj/3bhPXOAcHE+hzdbD9106AGX9jgzxqyT+S/WpTv7LTa55IIakIt1g+vV2Cp+CSval4cFQrw6KgimS3q5toiMe0BKctAgJvN2uKe6wt9nne2vhhtpxKw5wUiRGKMxp4Cg0ztPznf3zG2MSba0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39840400004)(366004)(6706004)(4326008)(6486002)(956004)(2616005)(4744005)(2906002)(86362001)(8936002)(38100700002)(66476007)(53546011)(66556008)(83380400001)(8676002)(5660300002)(26005)(6666004)(16576012)(52116002)(478600001)(36756003)(31696002)(186003)(16526019)(38350700002)(66946007)(31686004)(316002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0JubzJxOElXVGE0VW5YRTFkVTZranBva3pMK1U3MUE1V2MzZ2FEV01PSEtm?=
 =?utf-8?B?WExhcWYzWlBHT0M1eHhUMU1wQjN6MUxFdEVYQ1E4bU5qU3kyN2lRbElxRXh2?=
 =?utf-8?B?WXRoL3dBWFp2MXNONlJWMk9memd2WHc5bmNjSE1FR0w1b1k0d3FxSEljSGlH?=
 =?utf-8?B?dWtaK1JQS1k5aGtvNzdQazVSOXRwRURDeSsrSjl3VHJtUWlOZXJ6cFNMZEV1?=
 =?utf-8?B?Uzd4eW5BS24wb0hjL09xa0lPeDdDbUgrSVpZajhSZ2RPT0hlVDFNVUdvc0g4?=
 =?utf-8?B?UzE5RWlNL0diOURrS2JkWkZSK3NQMVVuUys3ZURKNW9WSEZ4dEtDQnpudGp4?=
 =?utf-8?B?TkI0ZGhXK21VcXNJblJYbHRwVTQyckF6TWh3dHNZWndFSjFyamIzM3NFbUE2?=
 =?utf-8?B?ZmF3TE1jTnNzTU1aanRISjFqWWRHM3FxazYrTFhITnpNQTJ5NkJwVys0ejBG?=
 =?utf-8?B?TTdvblR1a1ZtWFRoV1d4U3ZMNEptNjFEN1VlWVZ2S1BwZ2ZuMzFXRzFubWhm?=
 =?utf-8?B?eXNxUXpsNVB2OEsxY25mU2U0cmdUclU3bGZxcHNjVUJONEZabm5sY3pQSXRV?=
 =?utf-8?B?TWhIek9hT25GQTQ4RWplV1YzS3h2UlcxUkE3YnBBeFVFRFdoQ1MremplSHFh?=
 =?utf-8?B?VDFscUk0TlJhL3FaYk8ydHFTTXR4K1hUeTI5bGhyblM2YWFsK3Zld2NuZ2tR?=
 =?utf-8?B?ZEV3VmVDa2NrYzNzaG51WWNyc1l5MlZJbmhVNzA5OFVoN28rSm1PNklGb2h0?=
 =?utf-8?B?Zm1xRmozUVZCcGpCa1psZkFBUnRPWHI3REdMYTEvdGQwQ2haV2NyN25TNVEv?=
 =?utf-8?B?ZUk4bWx2Q0Y2STdjUEw5aENaRnFqalFZQVZNUUdKb2dJTGRiNVhueldpT2Jj?=
 =?utf-8?B?MEdjREsrbksxckNKRVRqNDRzUWo5dStseDNzOWVVc0tocGV0bWtDYnRnc29K?=
 =?utf-8?B?TU5NU1FiS3VMV3BwQzd6d0NHQk40UGVTcHhMMUxuZE5ZZzBuZkhGaGhPWUpZ?=
 =?utf-8?B?Q3VGbm1qdDF5VVhCclBQUkt6Tlo1eENMTGNHQjJJNHExNk1MaXZsdm9XVVpC?=
 =?utf-8?B?R3RTeDJMeXF2TDEyQ3pLa0lwV2xaUkxUVndUaGdBR2wxbVBXOHVwOTYySDkw?=
 =?utf-8?B?SEJNU3FoNEN2b0VGdVJ1UFh2Ly9qL3Vjb1JzVWVudEpNV3RoeG5zYmtEVXJW?=
 =?utf-8?B?L3ZvSmVkMzQ4cFV0WFA3SHoxSVNmV0dqbExvck85TFFtRW1GNXFIVlgrQjhU?=
 =?utf-8?B?NFY5NWJMeCttUE1mVk8zdy8rendYVkhzc1ZmNmNFdHEvVlFPWnZUSjVYN0tq?=
 =?utf-8?B?QWhZUmwxM3M3Z1pEKzBnUlNvV2h0c1JCOXNwS0VnNHFzNlZyRURYT0xVOEc2?=
 =?utf-8?B?cHhXODFtWWVOQU5OdmJUWmUyTzBnb1NUSEtSNXdkcmlwOTd4dlZoUGNsNlBv?=
 =?utf-8?B?QzQ1S3lnM1NPOEZ0dWZLK2NsTlVHVXdGVjhIcUNxbExzeVQ4TlhMdEhuTjZB?=
 =?utf-8?B?SGRuM3creDVKendEWE8xTEtTNmxNTEp1bUQwYitsQnZwcEl6TS9ROG9MOUMr?=
 =?utf-8?B?ZitGcExVQ2FHQ2wvTjFiYXVHNE1xd1FNSkcwVHRDeHZVajNrTmJybnBvQ25s?=
 =?utf-8?B?VlpCWUJyR1hCM2tOZmRFK0NnUnUxMDdNbC9Gb1RNdUpsRWpkcDE1NHRCcC9l?=
 =?utf-8?B?bUxENlZFa1BLR1BkYVZrR2RVSk1WQTFSY0RNZ1RINk56bXZEOFc5amE1MTEw?=
 =?utf-8?Q?S2Iut9p7jPiytZ3151DQSGKc8F/sqABX1rktDVm?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25f235e-d911-46d1-cb5e-08d93baeb04d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 10:06:11.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTRUyIGyd16ACtBgYFDqb0qYPW8r1f5yulpwxWBRYQSCkifgkyEJjoHp6d1PZ5InyHvEiDRmuByecQQNi8F+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4185
X-Proofpoint-GUID: kE3vM2VIoo1iwVxPTrNu1UDO7nMpz6mr
X-Proofpoint-ORIG-GUID: kE3vM2VIoo1iwVxPTrNu1UDO7nMpz6mr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_02:2021-06-29,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/21 2:20 PM, Xu, Yanfei wrote:
>> Oh, you are right. The current code doesn't actually prevent lock
>> stealer from actually stealing the lock in the special case that the
>> lock is in the unlock state when the HANDOFF bit is set. In this case,
> 
> How about setting the HANDOFF bit before the top-waiter first give up
> cpu and fall asleep. Then It must can get the lock after being woken up,
> and there is no chance happen stealing lock.  And I sent a v2 with this.

Please ignore this, It is incorrect. Lock stealing is a performance
optimization.

Yanfei

> 
>> it is free for all and whoever gets the lock will also clear the the
>> HANDOFF bit. The comment in __mutex_trylock_or_owner() about "We set the
>> HANDOFF bit" isn't quite right.
