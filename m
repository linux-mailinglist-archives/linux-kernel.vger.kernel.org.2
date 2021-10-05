Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849D9421BFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhJEBfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61778 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231898AbhJEBdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:47 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951AwcF019258;
        Tue, 5 Oct 2021 01:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6GaMKR0ahvcEhve8kvy1qZz4sHehBIPoWV1URH+ozTc=;
 b=ZQib+hCv1GQbiiK0DnJq85h2Hr+BBx6zJDhlfDJuL9H4ASwYWQ9LDoaavAj/jraWsjR2
 GMQ9BcOKbBap2HiX1xWilzTbehSJUTLkVW+B5U0Eu+pBdBa+61SnpjklPao5kdeUHM5c
 e7KBAp3gSusgWBpuNCm7AP8W4lz4DKKUibEaMsuYX+np0yXqcw21kr2RU8QXPrspjze4
 oB6E8yOB12tZrAyTYbrTt0U1yFE6HK0gOg8GhVKOkicUN0Q/PFa33pNazwWNntKF2ahw
 bUt6r7KYrqzef1WrUD40uQp1Bo2s7YlAjCqNHPBfDWHQf68PhVS72sphAQTb7lwVj4dP Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c9cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UICk178521;
        Tue, 5 Oct 2021 01:31:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3bev8w03ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw1s9d7x9s3SXUV4nZX3qOsh/9dhmgPAJ00/hCG3Hfltqq5rXHPMFv4ZCo9cnCtMTO+guBLrDHpayEcsa7k9kk6cDmeZjAEVEyUJ7eCLW0SxjF+IhpAKmzlxkNXR5n9xYn5QlMnu38Ytgo7nvOMd4tVLi5x8jrncYqlv46PU6AAUJGS05KIdsa0Fsn9rS5HYERiv/CY102Wq+d5NyO/B6HbTHTLeFmpM1ALQfc/QCXS5YPhnGP3SdZPCIGq5GYEuYl74tM6CH+EuPBFFuFTha1lToCGvim8h0ueMg0ENNjEF8SDpRAGcbXls30u4ctbHT+nuRgTQyD+l5v1rM57Q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GaMKR0ahvcEhve8kvy1qZz4sHehBIPoWV1URH+ozTc=;
 b=kZbvJWBwIiDe2cI2jPRLMRulhilZb9NZCOpS5AnGDpluUCxEyiz6y31ykorb4K9vigWg+Ziv+0b3vjcV+V/nuvQYtS4bS1swbRmuVCtit8LkhdEozgCNpnFcPf6AO5ZIJU8vFble03Mlokvhy7Vi0q4KCFqdqozN4GF8vGN9rDEojc+ikz4gO+GfWu2/3hnmsYMLbBFDEfxK1/8A3NmL46+Inveq9cDn8HpXkaYT9qNYk9ucFZOWTjUrOeOAKaAlquj6luge1QefaNFyDTUqlDL6pqJayCXHwp56yyg/hHGwgJGx9QXNi4URmRpUsMzL7WieoeszwnfxH9CFBoqibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GaMKR0ahvcEhve8kvy1qZz4sHehBIPoWV1URH+ozTc=;
 b=z2+lBeU7IEJ9f7eLLOBS6ZJ6JwV3RGvuNi4+Kfwm1nT4HzbCS+ju68BA8Vk7tbUwYvY61wHevbzesIf1xtokou5g6RByuZ4ZnqZhlNpDW8j9+Uaz6NaW4DAISyztzKzL+qaYcqE6hQYiuDPPNscXnotbH9MIenmt+R1KrKTOtyE=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:25 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 51/66] mm/madvise: Use vma_next instead of vma linked list
Thread-Topic: [PATCH v3 51/66] mm/madvise: Use vma_next instead of vma linked
 list
Thread-Index: AQHXuYiq/3tkLPqPCU+0p0CXaOC/4g==
Date:   Tue, 5 Oct 2021 01:31:05 +0000
Message-ID: <20211005012959.1110504-52-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d9e04ff-a53d-44d2-0dcb-08d9879fd883
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044B64361D17DEC7082BB22FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ax7vhjDLi2LnuzAuLssmlrZRgj/FgZFp88oQAvr4Sd3y+/xdx80U8ncMKoCrGQHMcp730t7iG0Sj6efbUxDQ1eCNFyoSVdJPTKxMsY9RsD6fvehI9qeKBRSA0wnDs9iJ/Q7BPLqdA5tVZiQg6n1z0pSjmYPk1Pc3zIQyH/GxpILccxYh8vubhYvG2CRu3Bs48VnvA+/Tjl6j43K+Gq3kQqkDkRnjncOs7OPN3fMc05MtiB1o8h++0VgEMyNDtxK8JQpCz8EBraSnNFCpmqEJ1UuqdJXO6md5oDtpTXouelkihcdZ9AYo+TkAmnTmlKR4MUXUV8XEb1qe+DLi+GwrwEIyPvWVMABj8lYdEVCElxn41rQoVWBO3BhmC3SgneXWVp7MhRn4dpq9c//k/xGKmxV7bn4PrV2jSn6ygEz0s4raZcPNdNL9/9zD529T3JRfW4+Kw9HsQFLGnJZ7P5dM2g0MSh+9reg9K3ZC5OYbMGtmM5AM0uQnDZYUe6qdAZx7kMUshUqW5DYX7Qzw1IVWcSm2DpzZ6lR1s7RpoQsn+tOv9Afl0t/usmi3PKNohB+AU5WK6KuGAEp6LwsuvsWCkv5DszPj5xMwtdtqH2SripRR/mDGDu2ntr5f3G8dzNnoG26W/AvI9elZmnCF82oef5KCpk3J8+MVsqs1AjUW1WQ/2YqqCG7QzcEek8S3dpTUshW1DAchUaoXPS/0Bo4iAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XrV9uJLQFFZu9Huc68i0uCHLczDPS2dEhJKc8a9haqD6OBTA3LGlIHz3rg?=
 =?iso-8859-1?Q?hNMjOz4MWhtk7zUHwFVtDlevvgtYVJyglxQu42nr5HRNTA4qz085ZBINKl?=
 =?iso-8859-1?Q?fIgTekElTMxn3e//wMCCUzUvYvBy70Rs8a4go3JhvF1Xq9W9b6PaK282Y0?=
 =?iso-8859-1?Q?f4FORzxwNOIHsfn9OBNxaSzSiJfVugHuvc+CAxwDJ01Hua4dredkaBxyMr?=
 =?iso-8859-1?Q?qlOAwyj+bH6+pFtorLHdoPh5deqjrJXEgWsavfWeKuKYu7JwXJmCeVHd8y?=
 =?iso-8859-1?Q?6bKUMjjnOYIp3+s6lCrS5VZyLBqbmgGbdAu8Sy8IEEFjkoMyGnjMjvEbQX?=
 =?iso-8859-1?Q?/Kam0mnquds5kvr4979UsB3/aUYnkcN5Kc6j9zz3UVo6rcH6lFG3GTRnty?=
 =?iso-8859-1?Q?S8EB+MAExzAgAH+KJAGyoq5DpZw2KeM4IkLNUvrz7SYyT7jLYv663ZwBgb?=
 =?iso-8859-1?Q?pORlIml1NbxArqZnNIfLiNC7lTkdh/Azpa8N/AIa1dvFD1dN69zDOb7Iuk?=
 =?iso-8859-1?Q?weQQwZ8USjuJ7ehR2e3Xa7YDpkzBeTXawrJEu9XkBoFymY/2wM5VmLoUqa?=
 =?iso-8859-1?Q?7SBuhgwtJUOW3dkiwgKgb1CW1GUzyzyJEhkGSpsW1KqfJe0pkb4Fiio5Bu?=
 =?iso-8859-1?Q?IePYUnmzFlY1EqvxaGvj/SPG4FiYo5BtO5jSPTejqp/TOA9Irogw3U0LMZ?=
 =?iso-8859-1?Q?OidJzXlygph6ftgVDL5b8EvkY7PzNQ8gaT4WBQUzyQ1Ul5Fq8x8b7N5tbP?=
 =?iso-8859-1?Q?RgperZcpnLbB6g445ofcUuRJ6cbdcKc0m/WOBua7QIkVBVw9V2iRqPPQrE?=
 =?iso-8859-1?Q?1AMASEwZjaya6+OsdUGtgHOwdOdu6FaiCjA0+VrxMiIYCNCkAtSH2JfVY0?=
 =?iso-8859-1?Q?7zlUXsevk/lQ5zxRBaXBdKcDXxc/0nBMtUHCR5cYhMVLaTT6m0DkJm4hR8?=
 =?iso-8859-1?Q?gCEox9T2PN8iG/22G+Tc9XUM3l9R8YWwiG/fOYerwevWLlI6lRPt8dJkjj?=
 =?iso-8859-1?Q?NPgLuLcaXUlf0VyQoaSvM09MwBQwKvvH2XJTa0vHsGJ3SZZy0nqdFNmXIc?=
 =?iso-8859-1?Q?3UQMK90gzEviYJXEinctvK6DtJL6Y8sEyKULPyT7urDaX7Dy+HGSq3F6Y/?=
 =?iso-8859-1?Q?gQJvF0NIwh7Aj49J3n4wgDEP9AcFRfkQCo+M2DOBW9KLuqy/eLCkI4cdb2?=
 =?iso-8859-1?Q?wtwNfGw3zuXfgf/zwYzfLJ3BivnUncokYLCEnj+MnDhjvKzzHKOJSZZEmn?=
 =?iso-8859-1?Q?UDHo+ThDQyKxm+AtsqnCNm1cmtRI5qO/REzJR87sFTPnIOtjS0H/2rY+0l?=
 =?iso-8859-1?Q?Pao4oUVpFu9tZ3VjOH3RisDY8V7BgdUvQvi16+FQ+cgaCDSq3PLKxYNjh5?=
 =?iso-8859-1?Q?cgEjtp0YqX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9e04ff-a53d-44d2-0dcb-08d9879fd883
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:05.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNDz/GcFpIW3iAATvlj9zWmnvskM4szepVP1Dqo3RhZIQ0UlUZ9/wTkG7XBDs6aC5PqHgBQC8B0IMZXVUYA6ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: BlzcQWpmDE8MOhqE__8sQFzX-vLM9zXq
X-Proofpoint-GUID: BlzcQWpmDE8MOhqE__8sQFzX-vLM9zXq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..3a6fe7e1b080 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1209,7 +1209,7 @@ int do_madvise(struct mm_struct *mm, unsigned long st=
art, size_t len_in, int beh
 		if (start >=3D end)
 			goto out;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D vma_next(mm, prev);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.30.2
