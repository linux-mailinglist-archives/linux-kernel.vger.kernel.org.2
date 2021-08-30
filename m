Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1AA3FBD03
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhH3Tjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 15:39:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26868 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhH3Tjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:39:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UGawGF016571;
        Mon, 30 Aug 2021 19:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mNsyUO4ethWMsuGGG2VlmrhXEcNYER/BrPqZbl3o+so=;
 b=X9AYmu363w1M8Ba0fb2zXz2eG41/r2Iu0GrWumb0zq1E477+NgyG4Eb/MS2Bzo4GHkvC
 8hAk+9GcV0JL1esZ1uwZq2v9VKZhRohdYjvuxHnS72tLXFfqLrrAWUvaKoMbE9WAQ969
 GGkKpMoIOOfmjFOIPCH50Eh5HvpvpFr+pnwH1A5n+9rHdFL8szT4+bHbE8yJAiFM7Ldl
 QEJVsVk1edrWFqtVYedqH49pA4t9zc3lHstmN55Pvkd+j//VE2MaBQGVgmgJvLgmZcl2
 uwoh5lvGc7gGlhEKQIiIbQmBj2FrqqNCe0vHV2hDiGiibQZTYJWOnj/1I1V2qR8w1YDl yQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mNsyUO4ethWMsuGGG2VlmrhXEcNYER/BrPqZbl3o+so=;
 b=m2xwTyZ/W+Iypfum+CEK4ngHK6jDP+T3fsYs7JbEi9ipw2kYd2WdTPgCmo/p/ZjoG0fm
 hUPXrs59F411Kf4iS1l1/I/PmeGhvcguxgU+NY1xF458RAFERvK/fFk+MvEvU9VFi7/2
 W0YvWXvE5uU4q02UDCLkAO537VjX6pGswfX8Nd3mq/ZDmLADZm9+UK66pk8DLLrTo0iI
 brxxS96W5tKYGJwMyoxyJKovx2FTWGM/AO6sZ1sQxv3r8B6leIngXRpeij9P+SMCse+P
 FgtVBfmVGkEjjftZl4aRHShLef6y0lL3XKyaY2A+eBvLckNCJxEn3VuTBqBrSzWIFV6V xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxxjgbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 19:38:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UJUCci156011;
        Mon, 30 Aug 2021 19:38:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by userp3030.oracle.com with ESMTP id 3arpf2wnvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 19:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euDYVb6DvUOmpLdCoM9p7qncGS8owVzuW3RedNHs0UpLzIUl9C0DgNtSghGtp+jcAJmZa43iFIW38sKPyf4PBXxoKlU+CJ/cSr0xNK0EKMU6UCfq1mOwQZ7uDeNY6KGMVEGd+fW5h24xOJVBizjsMFVe9HX/KZuMlGV5YHpE9P5dMkZ8f8BMzCfC7dmhXhjozc7ESjKjlhG6GWUKKjnUNwlhzlyC3Qn3mrqyyTA7EAbIYWkdQzEXtmEyPjZHtc/vjZvr7QFPnGBsFbc9y9/M8rXy4Nc6VdJnMEvNPjN0owhYuCyKh30ykwmQ5fUmbBIyLlSGxS+AHyOBAGHF56vuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNsyUO4ethWMsuGGG2VlmrhXEcNYER/BrPqZbl3o+so=;
 b=cj9KfgcPeTxx1SRtd0PQVDWXHy0MqQfV7BN7DrL0mbCIPRJ5wqQ9phjkwd5mKeeHQ1QlgSd1dEdnIZLJu7aM9RM98+vKZBKoaU23m5vb4N9hQi0lM2g39LNP54fjj1cwRmwBMIWP8d83e6LvXC8lOGzZSG4b5Aq07u6m71buYJPOpLgwL6O00ZGOws3Ei4dHG7OQBLA9DFJtpM0FcV+Xo1T9UYNDVbp/JEqBfdHPcAZpLnfsdIiVGImMjuRLZlIvjUgQFmfJyE/xpkaJGFqxvA0808ZB2lkZh8xWAav/KVieTK2n6lTLnqwiZxwdMY/Mekh96IPdbOSIP+nLc69h6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNsyUO4ethWMsuGGG2VlmrhXEcNYER/BrPqZbl3o+so=;
 b=tIog7bFxntA0yzRkWxw8Ayt6GsAfYVfk4qxiO+DtTreYyzIi6B/rqCl/tThTVwtXW7GIlfOlCKrHygKW69+8PzCuFZOGl0J+zQH8RZpXTbZrTXrmlrI9561IlEEygggGZ+PHXu+bHvnNzw5saDLgLe4lCJeNCYh24hsLAtNY2mU=
Authentication-Results: peda.net; dkim=none (message not signed)
 header.d=none;peda.net; dmarc=none action=none header.from=oracle.com;
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN6PR1001MB2113.namprd10.prod.outlook.com (2603:10b6:405:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Mon, 30 Aug
 2021 19:38:36 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::c027:a4fa:5d4d:fd4d]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::c027:a4fa:5d4d:fd4d%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 19:38:36 +0000
Message-ID: <4556646fd511050f41b517173d85888e3bd7cef3.camel@oracle.com>
Subject: Re: Why is Shmem included in Cached in /proc/meminfo?
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     Mikko Rantalainen <mikko.rantalainen@peda.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Mon, 30 Aug 2021 13:38:29 -0600
In-Reply-To: <0cdd0624-fcc3-386e-c651-7173dc3cbb59@peda.net>
References: <5a42eb2b-fd7b-6296-f5d6-619661ad1418@peda.net>
         <0d11f620-0562-e150-259d-85de8d10cd7a@infradead.org>
         <YSzuLbHr7fHshafX@casper.infradead.org>
         <14465cfe-281a-0f67-dc17-ead34ec48365@suse.cz>
         <YS0Eq+tNe4Pr7O0X@casper.infradead.org>
         <0cdd0624-fcc3-386e-c651-7173dc3cbb59@peda.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-137-184.vpn.oracle.com (138.3.201.56) by BYAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:a02:a8::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Mon, 30 Aug 2021 19:38:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b266c1bf-8af7-41e8-f76f-08d96bedc235
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2113:
X-Microsoft-Antispam-PRVS: <BN6PR1001MB21135444177FB786E2AD5E5086CB9@BN6PR1001MB2113.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7J9fG2HbKshVMqOSQvXA+llGWBDkqUWJavOkn7UW68eO6dHSwkQzwMmdtwiHRuZOfZfKDdIM5nXK2DObpvsoY6KIglL2eMQ1Rq2nd6uyOtcGj4zyjp8MebRJGY0SOCGzM8gHWe2vnx6Ot56tKFRaR8YLHxhXLdcZF0HdByZdgJPBRAjR6vUJYKZm796yt4TUksTvUHWnvVOsV0+sOKkMUrTkUGQF3+4nWv9rOIliveGbofI5mzZPMIU40EY3l0KdBGETGhlgjzDO1iKZq1Nsz9Oo4+qTRj5MwXnFPjZTjrBwj76iJRfYTxAvolusPxrwnx0gsrCTBhxewvikxEU6DBXMIh9m9pJvL7Jnycgw37ZM46g4zPFHQ6MotSLe3vniUVXKFlJAULMolqBw2IGoOfdF7xrTuY3ozQPoxR/njhR6W3iJoaaCydZEpTv2ZTFj038g6TBxg1VhirdxaBjBIGnx1b4Q7DJM9ZV3nQ1urx9S1fMj4MV66ShT+GaecY3XCec3Akagen70maVHSYDVsLmT/wWUg1iWAL0Ym6CEikIp+VIVqPg8gWSGOdr4rjqfOLQeYIhjcxvSRXBRMEtoor6nIHruIASi06O2Z6uE+Ziaeo8Dd3y97+NEUf9gS4po3CRPml5I098tyZrtmhW0iJTzgkNDnYsPcDK9pG6YjcsM1GjKT/5XsDGEjet3PEx7kswEHbtHmuVQNOHcrmlFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39860400002)(396003)(36756003)(4744005)(186003)(2906002)(52116002)(8676002)(38350700002)(38100700002)(7696005)(66946007)(66556008)(5660300002)(26005)(83380400001)(66476007)(316002)(44832011)(86362001)(6666004)(478600001)(8936002)(6486002)(110136005)(2616005)(956004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JzUnlpZVVuOUdmK1RKZ2tSZC8xaXU3QkMyQ2ZuajZhdm1RdnZkOUx3RTNQ?=
 =?utf-8?B?aDMxVEZjajJnb2wvZlZ0ZkdFaGE0UzNFRDZPV3Z3Z1FzUDAyNjZXZ2pxSFNa?=
 =?utf-8?B?TVc0RHZsWXVJYWsycDVyVW5wM2ZraFBIeW9WOXBJOVR2MzErZXROdjUvODNr?=
 =?utf-8?B?amdJWmdBdXFwMlRqT3hGTDNNUUhjLytVOGwzWnZRcGcyWFdNbURqUGhMcWVa?=
 =?utf-8?B?Qmw0WmU5aWhGME12d0NHN3NuZ2l0UzJnZ2RZdGRUdGhjeHk1WkU5TFlpOHlZ?=
 =?utf-8?B?enNPU01QRVhrdW9aQjlUdG16cUthRXBORUx3d0RhQ2RtVUFqZkgwT1kwRVZW?=
 =?utf-8?B?cDJKZ1prbkRxU3BkWEJYTFA3L0krR1hTYkZ0a3g3WVZhWEgveGZnR1h5N3dI?=
 =?utf-8?B?cXZhR3czcDZvUUxldnBJMXJ4ZitqT1FYZ0grN2ZMNG8wN1g4aHViOHdnYlY4?=
 =?utf-8?B?WG1QcFZvanJMdFV0amJEU2V3TklBTFpXYi83UmlrQ2J1U09LSFdqM1paTjE1?=
 =?utf-8?B?QkRFSVVyRHNCaUhWRGZseHlQeGo5WjY4SkJqTEc2M2lrb1RiQ2k0WDFGTkZS?=
 =?utf-8?B?ajFNc1BjVDZ6eHdVeWF1K2kzMlE5TUVZQUdtQmJNYnMySEp3NFpaaCtnNWR3?=
 =?utf-8?B?UENDNlBSU1RmOTBydThxM0JPYVlmSHNMdzVDdHp3cSt1QjlCTGNMYm52dlRn?=
 =?utf-8?B?REQvSDRxZjAzOGdUeHNNaTU0WVQxWVNZcWEwcmxSVGRaM1B6R2ZScldZTHVm?=
 =?utf-8?B?bzZXMkd2RDBabEE3WnVqbmEwRWI2WWtOTXZkWHE5RG04RGdxbGZIOFR6KytD?=
 =?utf-8?B?aVJaQU5qcmh4R0tHSnhqZ1hoM2FKRHFYWEdCd1k5Mjl5QjcwbDhaY2dPQXZY?=
 =?utf-8?B?VEdJWm9vZEpUZG5KcGR1QlQvTEpYRVlxeElDZTg0Wm1yUGRLMGEyaUhLVkNm?=
 =?utf-8?B?Nm00SGY0OVhNWXY5aXB1bk9wMTRLeXhtL0Y5UUZGcVZ4Q3VaTDRnNkNxb2ZE?=
 =?utf-8?B?NExDNnRQdzZNb2doSmlQNlZsR2hGc0k5VWxlNUdEOU5ma1ZvbEdCN1YveFhK?=
 =?utf-8?B?RFdCQ2prV0JZK1BIR3pOSm1XdGhXZElZVmV5dW1mQmxLRFpHVmZtSERqSVVp?=
 =?utf-8?B?aFBYWHA3Yk9TNmgvVVFNcGVlem1GZ1dXYlhwOStWZ0RHcTZ1MDh6My9JWExz?=
 =?utf-8?B?eGpHc2Z6THYyZWk0bGVmREQ3YnJ3dHJNeXdrZFd1bGl1KzUvL2lweVY5S3Vw?=
 =?utf-8?B?emtpYWU0RVQ5OVRZQ05naDBGSy83OGtIellHcUNSelJoeDFCYlNDQVQxME5L?=
 =?utf-8?B?WDJWVXhFMzJqRnprQjhyMVpJZjhaN3ozM0w1bE9nSkNnNHFvS2NGTUh5a3Ez?=
 =?utf-8?B?VlpHNVlMQ3RvSXNra2c0T1piT0ZyVnV3anZYYzBhcVAvaUpnZVc1Y1I1VE5Y?=
 =?utf-8?B?Z3RrOSs0MUNQYjh3UWdoQ1RDV2Y5WmRabWxSVlRRRnNScDRXc3JxWGczZTJW?=
 =?utf-8?B?OXJLUnpwSEtpSE80U3V3bUE0ZTQ0VitCaXdkZkUwRWZQdm9Sd1k4amxDb3dC?=
 =?utf-8?B?UUJVazZLbEVzZlpQdWVyTmJuRlVJNjMrMUczWEI1OElQWE9SSGxod3hXaFFY?=
 =?utf-8?B?RXVkSnlQb3UxWm83U0FiWUJDZld5V1ZOUlY0dDR3WmF0RVFFY0J4WXo5TE5h?=
 =?utf-8?B?L2lROWVLOTR1WnZiTUFnNzlnak8rdlZMNnNKd0hTMTYvZ0dna0x0Zm91VW9r?=
 =?utf-8?Q?XsDmECXvtd69yEGQeXGh6Ak57Rl2iwcSoQ0ig5/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b266c1bf-8af7-41e8-f76f-08d96bedc235
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 19:38:36.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW0obCVBN6NDEmqbmIbYAP8YmfwU3YU+uJU50NU4LO4lbysHBxwwGVscmJYKEXN/CKG6n64ROS14eVRxlvOg3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2113
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=931 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300126
X-Proofpoint-ORIG-GUID: vEkgA-t-MX-xR5S3O99qic5pktrKrrQX
X-Proofpoint-GUID: vEkgA-t-MX-xR5S3O99qic5pktrKrrQX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-30 at 20:26 +0300, Mikko Rantalainen wrote:
> ... deleted ...
> Of course one possible solution is to keep "Cached" as is and
> introduce
> "Cache" with the real cache semantics (that is, it includes sum of
> (Cached - Shmem) and memory backed RAM). That way system
> administrators
> would at least see two different fields with unique values and look
> for
> the documentation.
> 

I would recommend adding new field. There is likely to be a good number
of tools/scripts out there that already interpret the data from
/proc/meminfo and possily take actions based upon that data. Those
tools will break if we change the sense of existing data. A new field
has the down side of expanding the output further but it also doesn't
break existing tols.

--
Khalid

