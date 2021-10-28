Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF50D43E94A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhJ1UJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 16:09:10 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:27354 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ1UJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 16:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1635451603;
  h=to:cc:references:from:subject:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c/dydLvpYimmAbYr+ExMduYJHw1T/U3sgTmc9k4izYI=;
  b=PAB8uojEVz+kgFo57j9yd/2H5MlF5usZ6xkOJ1BjHItysWtdQXD5AR9f
   7f9oxfm9GRBHr9ZVpsbrg9P5MbEl8ksOKxwUX+S1D0Fta5iytju6MZdxn
   BZobPAKjiYLd4HOP/XghKw92J01a8yAhq3qOQ7q4J9q/V4SKaYxuPjFsz
   c=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: /3mbW+SlQ42GdGzv9u7fF1YQUD1rr5nDEFyMHYAXdhELnCyFWgdh0OOVg64Vx5V8SvFotHEjTo
 3YSyxT5coqDj6MHQQXV+JD+rTyTdccCAM4iiINpanPziMj1n3P4z0HhI5hM25i1QoUZudQ3UPX
 7xKl8mVtg5+4/r503/T0Y2ny1BQ/19NO5gscYvtn3AFGdqR0bUS9lFiVFTkNKrTQEqsdtpI41c
 0e2vigUCvmdfII1mS7uqzTCiTvJP+kib7uuKbA/I3Xr83KK0Pu+jzA7iiVSb36iqWcWXnK34H+
 juWUPz4e2/RTEpCaYh2M0Xfk
X-SBRS: 5.1
X-MesageID: 56621228
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:a5njUqJ/hddseN8KFE+RhZMlxSXFcZb7ZxGr2PjKsXjdYENS0zBRz
 WcXDWmGO62LZ2rweNxyaYqzoB5SvJXTzYAwGwZlqX01Q3x08seUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokcxIn5BC5C5xZVG/fjgqoHUVaiUZUideSc+EH140Eo5y7Zj6mJVqYPR7z2l6
 IuaT/L3YDdJ6xYsWo7Dw/vewP/HlK2aVAIw5jTSV9gS1LPtvyB94KYkDbOwNxPFrrx8RYZWc
 QphIIaRpQs19z91Yj+sfy2SnkciGtY+NiDW4pZatjTLbrGvaUXe345iXMfwZ3u7hB2tts1Sw
 98ckqfodg4WEreXibs2czRHRnQW0a1uoNcrIFC6uM2XiUbHb2Ht07NlC0Re0Y8wo7gtRzsUr
 LpBdW5LPkvra+GemdpXTsFFgMg5IdatF4QYonx6lhnSDOo8QICFSKLPjTNd9Gpu2JoXR6yOD
 yYfQQpPayvfbyBrAwc4Cpg+m8ONlCalaAQN/Tp5ooJoujOOnWSdyoPFMsLSe9mAQsh9hEuUp
 mvauW/+B3kyN9GS0jGC9XGEje/Vmib6RYdUE6e3ntZyjUGe3H47CRsYT1K3rPC1zEmkVLp3O
 xxK0ikjt64/8AqsVNaVdwK5pHqsvRMGXddUVeog52mlyqjQpRqeAWwfZjFEYd0i8sQxQFQC0
 l6PgsOsBjF1trCRYWyS+63Srj6oPyURa2gYakcsSAIf4J/5vZ03hxTDZt95Fei+ididJN3r6
 2nU9m5k3exV1JNVkfXglbzav96yjrzgUy0+7FTwZTqa5zxVftW0OKeIxEeOuJ6sM72lZlWGu
 XEFne2X4+YPEYyBmUSxfQkdIF26z63aaGOE0DaDC7Fkrm73oyfyIui89RknfB8xWvvobwMFd
 6M6Vel535RUIGexJZF+Z4a8GqzGJoCxSIy7CJg4gjdIC6WdlTNrHgkyOiZ8PEi3ySDAdJ3T3
 7/AKK5A6l5BUMxaIMKeHbt17FPS7nlWKZnvbZ761Q+79rGVeWSYT7wIWHPXMLtkt/3c+l6Lo
 oYDXydv9/m5eLanCsUw2dVKRW3m0FBhXcymwyCpXrfbSuaZJI3RI6CImu5wE2CUt69Uiv3J7
 hmAtrxwkzLCaYn8AVzSMBhLMeq3Nb4m9C5TFXF8bD6Ahil4Ca7yvfh3SnfCVeR+nACV5aUvF
 KdtlgTpKqkndwkrDBxGPMes89U4JET37e9MVgL8CAUCk1dbb1Wh0vfvfxf19TlICSyytMAkp
 Kan2B+dSp0GLzmOxu6MAB5251/u73UbhsxoWE7EfotadEn2qdA4IC3tlP4nZcoLLEyblDed0
 g+XBzYepPXM/NBpoIWY2/jcotf7CfZ6E2pbA3LfseS8Ox7F8zfx2oRHSuuJI2zQDTum5KW4a
 OxJ5PjgK/lbzk1Suo9xHu8zn6Iz7tfivZFAyQFgECmZZlinEOo4cHKHwdNOputGwboA4Vm6X
 UeG+997P7SVOZy6TA5NdVR9NunajKMagDjf6/gxMX7W3i4v8erVS1hWMjmNlDdZcOl/PrQ6z
 Lpzo8UR8QG+1EYna47UkiBO+m2QBXUcSKF75IoCCYrmhwd3mFFPZZvQVn3/7J2VMogeN0ArJ
 nmfhbbYhqQazU3HKiJhGX/I1OtbpJIPpBEVkwNSewXXwoLI1q0twRlc0TUrVQAEnBxI3tV6N
 nVvK0Aod76F+C1lhZQbUm2hc+2b6MZ1JqAlJ4M1qVDk
IronPort-HdrOrdr: A9a23:qtmsSajLR9p542zNpPwYHUIZW3BQX0p13DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3I+ergBEGBKUmskKKdkrNhQotKOzOWxFdATbsSkLcKpgePJ8SQzJ8k6U
 4NSdkYNDS0NykBsS+Y2njJLz9D+qj/zEnAv463pB0MPGIaGJ2IrT0JbjpzencGNTWubqBJcq
 Z0iPA3xQZINU5nFfhSURI+Lpb+TpDw5d/bSC9DIyRixBiFjDuu5rK/Ox+E3i0GWzcK5bs562
 DKnyHw+63m6piAu1Dh/l6Wy64TtMrqy9NFCsDJos8JKg/0ggLtQIh6QbWNsB08venqwlc3l9
 vnpQsmIq1Imj/sV1DwhSGo9xjr0T4o5XOn4ViEgUH7qci8fz4+A9opv/MQTjLpr24b+P1s2q
 NC2GyU87BNCwnboSj779/UEzl3i0uduxMZ4K4upk0adbFbRK5arIQZ8k8QOowHBjjG5IcuF/
 QrJN3A5cxRbUiRYxnizyhSKeSXLzYO9yq9Mw0/UpT/6UkToJk59TpX+CUnpAZCyHpnIKM0oN
 gtMcxT5fhzp4EtHORA7dw6ML6K41r2MGTx2VKpUCba/Z48SgbwQr7Mkf4IDbKRCdY1JKVbou
 W3bLofjx9qR37T
X-IronPort-AV: E=Sophos;i="5.87,190,1631592000"; 
   d="scan'208";a="56621228"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2CPL9JawaUWSqIRZJchDuASXQ0SFTVdrKJtKHF8QboyaW2WzFMfEZZw+hro2W0m9EyCa2WFHvZYAKXl8bjm0NluHIPPW68PNM3lsq7DJfHzEZsLCWJG5oxJaQD83U9oymBax01DX96cj+s9cdE1xpLzyj39utwZqZSusT0O1lI4QZlQMhmbFOVhjKzq5h6PRSh556oPUo19X2/eNNbpQpuIr1fwuNtn1hJMB291rb777aNTYoLnr2pGQfwjx5Lr2AI0xYmeeQrLrMekOcNAecDjGqYyGiP9pcP4tOu41cr3K/wAo2nAoIiBJDRlyz2WKic/2UU7JtlDpIbrMqUqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKyzIu0xoYf7zbylVTeZDd9eF+2pBBPsh6hnpJnCXN0=;
 b=mpQJtGff9dqZ2QGyOEZBGEGSftMDlh6G/zXotQDLBXW9xVQu0bSYRDuLkn/1isHNGLod4LqzeI6l7lsLBwRkpRBO2ILbB8WdYJ3F68ycrxR3KKpahMkvOxQzfJqxkfWCMaYGQW7CfDAlFyaR66fyU4yFvnDQspAWa0Gvi+xzlRkt5sc/hKtGgqvs7R4vTqPz+2o0dJxgQRmw7TZKknAvEOfwGvDIKGFxPhcTjk1hAtNXKprMlU5mMBU46Prce0AH47ZQP1Fk0L/P4IvPO4VjDSVx0QCNIFPm+N9CxUEMMDSrfrNjgigxXQODmE1CgrUBQCEpF8hpFF9v6qvr/TRhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKyzIu0xoYf7zbylVTeZDd9eF+2pBBPsh6hnpJnCXN0=;
 b=kaumeB/9rM50UMUXAMVCtBzx+1MXKKXENnf4FWzKb0t0Ft+dgozs1Z1F/gKDe9Toy7H1agCRPl+Aw98Xeeq9eo3G0Pyp4e1y/mujcUO3g9uNSb8Lw1W8NbZbf4+j5aj/XL1lsmwTHEWf1eFZL0sK0nVRPOteXUjCfkI9MuuaY+s=
To:     Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, <hjl.tools@gmail.com>
References: <YXqNAJI3NJz3SQue@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [RFC][PATCH] x86: Add straight-line-speculation mitigation
Message-ID: <8ad13850-10fc-f8a2-c35b-4afe847b7f4e@citrix.com>
Date:   Thu, 28 Oct 2021 21:06:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YXqNAJI3NJz3SQue@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-ClientProxiedBy: LO2P265CA0384.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::36) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f04e53c-1831-4ff9-6858-08d99a4e7319
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6270:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB6270C225EC8069492A5402A2BA869@SJ0PR03MB6270.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuHZNjB5sQqsGmPu4taJS049peA2yEoK+C8nlB2OF6eMiCnm13x+yuT9VcL2iyobf4kGA5yXWfSREn6b3xtd4aM3MxD6aI3hY4jN9iWAILUGc9lOMHMd1/f6AG4Fj0ukzkhAJOZIdjr+vWWw0iFW7saW7g0vq+po/XBQlZ3VQdvfE8EaTyK6dMT3YL0fPF8rvklQwMVOFkG/aq9cQBJ/Ci+mLXifoJYTML+gn9UrdKfe4RCgwb/hxAniuUyel8Y7QsiRP21ZEbr8SK58Kktvcih+JQXeJgENbjTKcldbPlD6P44w9plnVC2HewvPlqikS2i1ozcMJIq/e0dZqxdFExQd4NxXKyeMhixH66t94cNpslwWdacG5jJfxUA+U4Ifmu93R3UmrLUOZs7SKnIC5E34SGRPSTHNuMuO34rWJGmxQkBUWyFkXDW31SUrYAmLTo99lCEEQdIqMcPuUvNF/RoKpGzAJL8ESw4yK+b/MrA7siMjLyxYr1fJVTHwmUuxVwQOi8dAGFQFHOC7WUo5xi8Hgng/Lq7qvPauemRECHynIIc9gx+YA5JH5s5ZUWfL8GuhIbs9wtodc5+w09BvmVACkhqpGt492wLBNGIGRnIhY9Aa7ZVsJDSpK1Y6bmx/2qCzk1b9yGLmaQC3PoPxgC+IrJvr9gJLSw09BwKdYgs9jfXB/YaFE3YVYklnqzjEFmZykG09dDtOO7ZTY/h+eHalMvgMq8+I+l+dUahuiT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(31696002)(38100700002)(66556008)(83380400001)(54906003)(82960400001)(316002)(66476007)(66946007)(8936002)(86362001)(186003)(6666004)(26005)(16576012)(2616005)(508600001)(19627235002)(5660300002)(956004)(8676002)(110136005)(36756003)(2906002)(6486002)(4326008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW9DQlB6K0h2cGRjQzNUZVNuanppRjM5RDZGeEhabUhEUlZySDlROU1qY1BQ?=
 =?utf-8?B?V3N6bzN1V3hTWTY5Z05FWHZvVnUzMzJLNmtHREw3QjdUTDQyYUVJUnIvMDh2?=
 =?utf-8?B?dVA0c2M5R1hnbHBqRlF2bXNSdzkydWRsdXc3Nm9HUFdoenVLLzBwaUpBVHdQ?=
 =?utf-8?B?V1I5L1VCK2l6RHNVaTdrOENiTUZaN3hINDNTWENLZjY5VEFGWkplT1Jnbjlx?=
 =?utf-8?B?c3NQTjlqalI2MEg2ZFVzbE5pN2R1WUU2dVBhZ012cDRMYm9QL1pYRFNZQlkx?=
 =?utf-8?B?ZlpVU3ZDM0pjSGEweHh1Z2xlOEtsb2lKd21sRzZycDM4aEVPbGRnVUh3M1U4?=
 =?utf-8?B?RGFCYlhSZUs4eUVmY2txNWhKM2R6MVUzN3M3eExNMkpSMm9USGlaZnNhMndm?=
 =?utf-8?B?UmdNZUhETmo3QllOUFF5bGlFSlpKdjY3Zkc5elhQR0lTUXVuUE90OFFtWk9Q?=
 =?utf-8?B?cFV0QmdzUEdqUjVSdFN6Z3J3RlZ6TjNGaDNOWGx5UTNPejY0UmUyK3puNldi?=
 =?utf-8?B?eStya0JURE85L2NBbWhEM0xmYzFNT1FsKzlQZ0lQejlMRVRlVmIxWUxIU3JK?=
 =?utf-8?B?SzErZDM5V2RVZDRZNm94WlNSYzhXTHRHdWVTczlYTUk4VHREWnhwY3dQM2tl?=
 =?utf-8?B?NllCOGwxU1UzRkJ4WmVWL1BXamVaVUQxdzlNd3lOQko5ckdQVTJvcEtjOGo0?=
 =?utf-8?B?Y280ZDdZVTdDSGRZRHI2ZFB6cGY1NFhodSsrMFdCZWFhekhQWjNEVHRSdGlx?=
 =?utf-8?B?a1p1L25oWEdUT01EaWg4cWxXVXhXYm5tUWs3YjdEMjJGL3dqQkpmbkd1VG1t?=
 =?utf-8?B?aFRjdFYzd3ZEV2Z4RmpMcmdiL04zeWNTNGJsdWozWVJhTm5HbnBadTlmR082?=
 =?utf-8?B?OTlLdzQvUFdPUVlacnBBZmR3bndnMit6dTg4ZkdBZW1Pd2VhWTduZ2tMSzNC?=
 =?utf-8?B?aUF4K3BzRldIWDcwWldOcEQxZkhCTE5xd1JCWE9YUWFTTy9aMzFkTXMzRWRG?=
 =?utf-8?B?Z2ZFSTlBYlA0cDhId3Jybi84WkxJVkkyZFpVNDBySjg2TFUvbU5OQ0RHTWxF?=
 =?utf-8?B?NE1yNUFRV2p4d01HTldWZFNaVUg2UjMzODVoMzZnaWhCWi8zeXZ4emRSdXY1?=
 =?utf-8?B?ZUVWeEthVGp0ai96aHdiUWlwNFhhL0wwWDRyRWxQRnNJdEtsZGdJV0Z4WmY3?=
 =?utf-8?B?TDJZaG12TXZKY2gzVGNFQTZEUTliUG9CU2dvVE5Kc2R6cFp2aDROYWJMLzg2?=
 =?utf-8?B?RlUraGJNT2hpYnlYYW1EU25laWN5Yk5Ud0UrdTI0Y0xvRmRUY1ZBNFJxRVRC?=
 =?utf-8?B?b2h2MldwbE5OWDZVeGJxdnJZTlJxZnIweTFzNG1XUy9OKzNXcm9YSnVVQWhU?=
 =?utf-8?B?allVczdBREc4azAzZS9veFBxSGo4TzhKYWF2R05aZDRDMzdieHU1cnE4R2h5?=
 =?utf-8?B?YlBZNEhqck11LzFYVEJNZkRiK0puY1pUbzJDV1hoRXlRVVZCSXEwdk50NU5k?=
 =?utf-8?B?NVozT0Z6UzdYOGZIRVFod2N6b2IyM2lmaURhTzVJL3lvVTR3T3NxRDBjd2d2?=
 =?utf-8?B?clh3Sk42TzZuUG1NcW5sR2xNT3hlNDYwcHdiZHNablNmTUF3dU5xOHBiTTBJ?=
 =?utf-8?B?RzU4QlMzUnBIVWxxYlc5MGdiWlBoVGozajRPZVYrekhGNTRNakYwVUdwc2hE?=
 =?utf-8?B?ZkJtbHdBK2hrZWdvZzJ2eXU4YTNDR1FKMGpSc043U3BvKzRsREMvU1JtRmk5?=
 =?utf-8?B?eCs4US96YytTYkwvdWxxY2svNU1BUnZ6SVlRVkVDeTdEQ1hvMWdTZmhNbUlF?=
 =?utf-8?B?Vk54OHQ4RmoxSWltMDFFeXdiMlo1OUVIUnl1K21kbVpKS3A4ME5wcCs3S2RZ?=
 =?utf-8?B?N0FYZmFwdUtzaWNwcncvcHRsWVkvYVFUZDlVbTJLQWVHdEVPZGNYUm1DK3Na?=
 =?utf-8?B?dUoxM0l3N1hNYWh4ekNNQlNOQisrODFuRVduVTZXUnovQTNIWTIwTkVYblZx?=
 =?utf-8?B?TEhHUDR6ekFMZTNZa0c1VURITkFrdThNZUNiM0xKdmNJam9yZkZxOTZMck54?=
 =?utf-8?B?KzBFVGpSeEZobzUvUk9XMitHMGt5TW4wZ0YyVlpaT1hFTHp3cldEQ2RtR0l5?=
 =?utf-8?B?dzhKUmFzTzNFK1RnNk9ZTGRWRnJMd1FTUXZieUUwRFhmNVFnNUxIZERvbFA3?=
 =?utf-8?B?TVpmR2ZNNENrQ3Vqd1dMS1MrODF4aUwwMGlNa3RVeGhaMXVVOVJjckkvYzBL?=
 =?utf-8?B?RGxtUk5CZ0JlQkM1MHIraUhtUFdnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f04e53c-1831-4ff9-6858-08d99a4e7319
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 20:06:38.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOhdNSAFOX/JBs4oVELbgWBkp+LrS4PCNNaTQyw0ffqS+TSKCL9wooiAuaq3XBycAg8ieeCpr7OV/+CJKovDytDmAUjNFGW6SdrYeGnhRwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6270
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2021 12:44, Peter Zijlstra wrote:
>  arch/x86/Kconfig                              |   12 +++++
>  arch/x86/Makefile                             |    4 +
>  arch/x86/crypto/aegis128-aesni-asm.S          |   48 +++++++++++--------=
---
>  arch/x86/crypto/aes_ctrby8_avx-x86_64.S       |    2=20
>  arch/x86/crypto/aesni-intel_asm.S             |   56 +++++++++++++------=
-------
>  arch/x86/crypto/aesni-intel_avx-x86_64.S      |   40 +++++++++---------
>  arch/x86/crypto/blake2s-core.S                |    4 -
>  arch/x86/crypto/blowfish-x86_64-asm_64.S      |   12 ++---
>  arch/x86/crypto/camellia-aesni-avx-asm_64.S   |   14 +++---
>  arch/x86/crypto/camellia-aesni-avx2-asm_64.S  |   14 +++---
>  arch/x86/crypto/camellia-x86_64-asm_64.S      |   12 ++---
>  arch/x86/crypto/cast5-avx-x86_64-asm_64.S     |   12 ++---
>  arch/x86/crypto/cast6-avx-x86_64-asm_64.S     |   10 ++--
>  arch/x86/crypto/chacha-avx2-x86_64.S          |    6 +-
>  arch/x86/crypto/chacha-avx512vl-x86_64.S      |    6 +-
>  arch/x86/crypto/chacha-ssse3-x86_64.S         |    8 +--
>  arch/x86/crypto/crc32-pclmul_asm.S            |    2=20
>  arch/x86/crypto/crc32c-pcl-intel-asm_64.S     |    2=20
>  arch/x86/crypto/crct10dif-pcl-asm_64.S        |    2=20
>  arch/x86/crypto/des3_ede-asm_64.S             |    4 -
>  arch/x86/crypto/ghash-clmulni-intel_asm.S     |    6 +-
>  arch/x86/crypto/nh-avx2-x86_64.S              |    2=20
>  arch/x86/crypto/nh-sse2-x86_64.S              |    2=20
>  arch/x86/crypto/poly1305-x86_64-cryptogams.pl |   38 ++++++++---------
>  arch/x86/crypto/serpent-avx-x86_64-asm_64.S   |   10 ++--
>  arch/x86/crypto/serpent-avx2-asm_64.S         |   10 ++--
>  arch/x86/crypto/serpent-sse2-i586-asm_32.S    |    6 +-
>  arch/x86/crypto/serpent-sse2-x86_64-asm_64.S  |    6 +-
>  arch/x86/crypto/sha1_avx2_x86_64_asm.S        |    2=20
>  arch/x86/crypto/sha1_ni_asm.S                 |    2=20
>  arch/x86/crypto/sha1_ssse3_asm.S              |    2=20
>  arch/x86/crypto/sha256-avx-asm.S              |    2=20
>  arch/x86/crypto/sha256-avx2-asm.S             |    2=20
>  arch/x86/crypto/sha256-ssse3-asm.S            |    2=20
>  arch/x86/crypto/sha256_ni_asm.S               |    2=20
>  arch/x86/crypto/sha512-avx-asm.S              |    2=20
>  arch/x86/crypto/sha512-avx2-asm.S             |    2=20
>  arch/x86/crypto/sha512-ssse3-asm.S            |    2=20
>  arch/x86/crypto/sm4-aesni-avx-asm_64.S        |   12 ++---
>  arch/x86/crypto/sm4-aesni-avx2-asm_64.S       |    8 +--
>  arch/x86/crypto/twofish-avx-x86_64-asm_64.S   |   10 ++--
>  arch/x86/crypto/twofish-i586-asm_32.S         |    4 -
>  arch/x86/crypto/twofish-x86_64-asm_64-3way.S  |    6 +-
>  arch/x86/crypto/twofish-x86_64-asm_64.S       |    4 -
>  arch/x86/entry/entry_32.S                     |    2=20
>  arch/x86/entry/entry_64.S                     |   12 ++---
>  arch/x86/entry/thunk_32.S                     |    2=20
>  arch/x86/entry/thunk_64.S                     |    2=20
>  arch/x86/entry/vdso/vdso32/system_call.S      |    2=20
>  arch/x86/entry/vdso/vsgx.S                    |    2=20
>  arch/x86/entry/vsyscall/vsyscall_emu_64.S     |    6 +-
>  arch/x86/include/asm/linkage.h                |   16 +++++++
>  arch/x86/include/asm/paravirt.h               |    2=20
>  arch/x86/include/asm/qspinlock_paravirt.h     |    4 -
>  arch/x86/include/asm/static_call.h            |    2=20
>  arch/x86/kernel/acpi/wakeup_32.S              |    6 +-
>  arch/x86/kernel/acpi/wakeup_64.S              |    1=20
>  arch/x86/kernel/alternative.c                 |    2=20
>  arch/x86/kernel/ftrace.c                      |    2=20
>  arch/x86/kernel/ftrace_32.S                   |    6 +-
>  arch/x86/kernel/ftrace_64.S                   |   10 ++--
>  arch/x86/kernel/head_32.S                     |    2=20
>  arch/x86/kernel/head_64.S                     |    1=20
>  arch/x86/kernel/irqflags.S                    |    2=20
>  arch/x86/kernel/paravirt.c                    |    2=20
>  arch/x86/kernel/relocate_kernel_32.S          |   10 ++--
>  arch/x86/kernel/relocate_kernel_64.S          |   10 ++--
>  arch/x86/kernel/sev_verify_cbit.S             |    2=20
>  arch/x86/kernel/static_call.c                 |    5 +-
>  arch/x86/kernel/verify_cpu.S                  |    4 -
>  arch/x86/kvm/emulate.c                        |    4 -
>  arch/x86/kvm/svm/vmenter.S                    |    4 -
>  arch/x86/kvm/vmx/vmenter.S                    |   14 +++---
>  arch/x86/lib/atomic64_386_32.S                |    2=20
>  arch/x86/lib/atomic64_cx8_32.S                |   16 +++----
>  arch/x86/lib/checksum_32.S                    |    8 +--
>  arch/x86/lib/clear_page_64.S                  |    6 +-
>  arch/x86/lib/cmpxchg16b_emu.S                 |    4 -
>  arch/x86/lib/cmpxchg8b_emu.S                  |    4 -
>  arch/x86/lib/copy_mc_64.S                     |    6 +-
>  arch/x86/lib/copy_page_64.S                   |    4 -
>  arch/x86/lib/copy_user_64.S                   |   10 ++--
>  arch/x86/lib/csum-copy_64.S                   |    2=20
>  arch/x86/lib/error-inject.c                   |    3 -
>  arch/x86/lib/getuser.S                        |   22 +++++-----
>  arch/x86/lib/hweight.S                        |    6 +-
>  arch/x86/lib/iomap_copy_64.S                  |    2=20
>  arch/x86/lib/memcpy_64.S                      |   12 ++---
>  arch/x86/lib/memmove_64.S                     |    4 -
>  arch/x86/lib/memset_64.S                      |    6 +-
>  arch/x86/lib/msr-reg.S                        |    4 -
>  arch/x86/lib/putuser.S                        |    6 +-
>  arch/x86/lib/retpoline.S                      |    6 +-
>  arch/x86/math-emu/div_Xsig.S                  |    2=20
>  arch/x86/math-emu/div_small.S                 |    2=20
>  arch/x86/math-emu/mul_Xsig.S                  |    6 +-
>  arch/x86/math-emu/polynom_Xsig.S              |    2=20
>  arch/x86/math-emu/reg_norm.S                  |    6 +-
>  arch/x86/math-emu/reg_round.S                 |    2=20
>  arch/x86/math-emu/reg_u_add.S                 |    2=20
>  arch/x86/math-emu/reg_u_div.S                 |    2=20
>  arch/x86/math-emu/reg_u_mul.S                 |    2=20
>  arch/x86/math-emu/reg_u_sub.S                 |    2=20
>  arch/x86/math-emu/round_Xsig.S                |    4 -
>  arch/x86/math-emu/shr_Xsig.S                  |    8 +--
>  arch/x86/math-emu/wm_shrx.S                   |   16 +++----
>  arch/x86/mm/mem_encrypt_boot.S                |    4 -
>  arch/x86/platform/efi/efi_stub_32.S           |    2=20
>  arch/x86/platform/efi/efi_stub_64.S           |    2=20
>  arch/x86/platform/efi/efi_thunk_64.S          |    2=20
>  arch/x86/platform/olpc/xo1-wakeup.S           |    6 +-
>  arch/x86/power/hibernate_asm_32.S             |    4 -
>  arch/x86/power/hibernate_asm_64.S             |    6 +-
>  arch/x86/um/checksum_32.S                     |    4 -
>  arch/x86/um/setjmp_32.S                       |    2=20
>  arch/x86/um/setjmp_64.S                       |    2=20
>  arch/x86/xen/xen-asm.S                        |   12 ++---
>  arch/x86/xen/xen-head.S                       |    2=20
>  samples/ftrace/ftrace-direct-modify.c         |    4 -
>  samples/ftrace/ftrace-direct-too.c            |    2=20
>  samples/ftrace/ftrace-direct.c                |    2=20
>  scripts/Makefile.lib                          |    3 -
>  tools/objtool/arch/x86/decode.c               |   13 ++++--
>  tools/objtool/builtin-check.c                 |    3 -
>  tools/objtool/check.c                         |   14 ++++++
>  tools/objtool/include/objtool/arch.h          |    1=20
>  tools/objtool/include/objtool/builtin.h       |    2=20
>  127 files changed, 447 insertions(+), 387 deletions(-)

It would be remiss of me not to say...=C2=A0 In Xen, I've currently gone wi=
th:

#ifdef CONFIG_SPECULATIVE_HARDEN_STRAIGHT_LINE
# define ret  ret;  int3
# define retq retq; int3
#endif


which avoids needing to patch any asm files, and therefore is a far less
invasive patch.

I know those defines probably deserve a WTF, and will confuse anyone who
doesn't understand the phrase "painting blue", but they have the
advantage that casual contributions don't need to remember to avoid
naked `ret` instructions to maintain safety, making it a rather more
robust option.

~Andrew

