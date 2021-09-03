Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48C3FF8AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 03:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346908AbhICBg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:36:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21928 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239384AbhICBg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 21:36:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182MsHvs023072;
        Fri, 3 Sep 2021 01:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=f3J5LxobCo+YW25BqZzFbA5/klPhPkRxscMUiUZJh+w=;
 b=Ykzl1yumRcAq3gtUUTKB85WYYSMxYepxEwmYcBGd7Swdx8ORNuKAt19tQE4pPGcKUfWg
 dHk44lzlR14fBC/z//GA+un70Oqxbkh61yeoZcGnLNZAkKRPbxNC4z4RQr9jWjzbjM1J
 qelnRDHoDghmRZ1tAjLPQNTosMEWmZbFNwaEr2Yg4VSxX5aYh7a4RBUmNnMPjWLHU9lj
 9uOj3wOlS+nw6v/gJZG2ebI9sFp27l2gSxyIW5caUkvBJH2EB3Mp0cczFUlbDDi201NB
 qJzsbwoJWojAlm6V7T586g65gYUgHy2+JV59i49TUhBTbkDPTLScf9XaPElX/Ric9fzO rg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=f3J5LxobCo+YW25BqZzFbA5/klPhPkRxscMUiUZJh+w=;
 b=Sv6TOSshpYapQn6ITdvirErCF9rQkVoQPReeiXZnqtYDuzkWLRIDMWsWcQbCJzCgsgqF
 W7tZ7DCQiXdi2CjdSD1BnhMrW1OhAYvEuz7U52wWZq40TWaQaXmSwGjXb1p0IRgqI7mk
 bUuC2Dq2MdbjrDb/WCquPoro9LTSdlte1ITRyZPQCXYHDOInsjr4JA5oPrI+ciF+yIpV
 3kGMIuEsYgK/M4M0BF6few7RQj3m7KLYfcUHvqYcAIY4X8DGWR4v2sefcjXr/nvkyR+F
 kNZ06jtoikZAS8L3JuJWkG0/jCkM6WPtlbr2D6FQ+iRMZiMMLqVOHjd578+odL5shHuT gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdvymsmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 01:35:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1831Twxe050568;
        Fri, 3 Sep 2021 01:35:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3020.oracle.com with ESMTP id 3ate00tcd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 01:35:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLi0G1Hph8mwZS3QCkW2psJPVsyojt22hFtx1xhr5xyVjuxSZRhKOydBPdWAu8uAsUAJyoVOg83qcAig+hfHkgp3u+NM4/WO8crwg9PvmuRkcuLQ1qFks/MwN4UEPwxbLZSzdSM/J6IbXMPpafFnMaeQ9UoIK50afyz1kSkik42xm/l2+Bp2v/P8TX8VkQddChbqnGj+i/vR4XBDzsDpNb3u7p5iIb/UI+SLFMpW1BDjs9cQcAQRjBcJooxtapUJ9NJ9rMTfGkcedV0vyjtJNFv0Xyw5j+SPWS55svXbPtscGMs9uUdt1OebWfLK2iixTp+InjnU9oajGnr8SlI3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3J5LxobCo+YW25BqZzFbA5/klPhPkRxscMUiUZJh+w=;
 b=WJfLJJGssyhe8TH9Z7JxCga1QRY3m8rvFZXqe3xDMPhPfIOkrir2j8XjOtQqLBgPiRR8754EbZauF5TRf+5LtWAlHO9BHzjDy+CL1C0++Jb7jNiIyrVwzuc/XzWeohw+Qg3BNxuLrCffd+wYn08lgXbYgEM+7cCjrTPSi9aOXoppNODcfNK0kwTu1l62IIdHFKGMzOrErOUd3RN9tJ7RzSb7FLgAX3A8sIbNyHc+XkO06Wew6fRDJZZxBl5KOd+nZH4U7q2ZML4r5nl37LDcPKIlrVfz791fbuYY+lco9o/U3ErVdgdwjro9EyDDBXTjVx2EU+edfSHhjgsVmq9woQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3J5LxobCo+YW25BqZzFbA5/klPhPkRxscMUiUZJh+w=;
 b=oTG+OPZy4opqPZcJiYqmSJaTOruTqrTJoA0y9VWAKEqhMho6jcwDHDPMchkI8FVH+AlAyJWLZS5JFT5xhZQsBIJ+5MhPCwmpCrRQ4kImNRGCMPNaaZH4p/fAvwlC/TqH0TT/s7LL3nDZOQZNjfB7shVk5wP98xZHJEjnxdG5xpo=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3258.namprd10.prod.outlook.com (2603:10b6:5:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 3 Sep
 2021 01:35:32 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.020; Fri, 3 Sep 2021
 01:35:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mmap_lock: Change trace and locking order
Thread-Topic: [PATCH] mmap_lock: Change trace and locking order
Thread-Index: AQHXoGP7cpc0Z7mp8UOLUJvtQyIsuw==
Date:   Fri, 3 Sep 2021 01:35:31 +0000
Message-ID: <20210903013521.1802774-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aef53407-218d-4426-d13a-08d96e7b1e61
x-ms-traffictypediagnostic: DM6PR10MB3258:
x-microsoft-antispam-prvs: <DM6PR10MB3258F9B610AE096840DE14CAFDCF9@DM6PR10MB3258.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4Bc1iPwmZPCb9j6paj6nUb7Sq7sHbMPhu9yfptt/f65EgZwDzYR+rhbzGH8+OOkfearyoImMaOCnrHj8ATPv/J0a8rH5Tc7HSYT77sFlZd4dP+KMEsQZ4cql5s5RO4WrZUnjG1GkcIK/rrSiipKd1inFl+2SDJ8e0p8j5WjQB810WbtvMzfSlUUeajEAtOu8AMXOowpmNnVesPiSwe/hW9s9/7y3JXSehkma6TUV3Wd1JY3TVzhV+ShsO/TSxLERKcEc10uBcR7BNdZ2hF6H9/oinha6eNmewOsJICikglEvyU0MG2EWzdiqNh5lVNbAdtiU6vnvw3YWbTBsQ4ppG8ueH2FJAsuENvb5Y80O5rbXSh+XqVrI/MPKYZ1Y898B0pxhjDX4YmwOrPUobvYLcEetuSrlxBQw8kjEC+vdnB68aksaiiTp9dkTZcf12wlw66MisvumVAo+Qopv6sTcdFDUMpWC98CAOAZpNZsfMB1I+jsQaVyRLEL3fW6VoPmQ0Rfy0pIOuNeISfzGy+RkxJrCZb+Rs4ubO0+Bw7LZAmJG1R2DoOcpnli6asno2lcF9rqUxEohUVL7lbWtKbXMhdB4UOtONL3I0UQX11wg1+ay2B0ShsDNarH8qpzzUoN67udp4BScvwfSsFHL/b+cDxE2m7JlUkdHRYWx7sDOB2tLLEqotmloHyLIIR8x6BkM89KBIMSKosEMp9EmTkaoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(71200400001)(66476007)(508600001)(66446008)(76116006)(66556008)(38100700002)(316002)(1076003)(4326008)(91956017)(2906002)(122000001)(66946007)(110136005)(83380400001)(6506007)(54906003)(64756008)(8936002)(44832011)(5660300002)(6512007)(86362001)(8676002)(26005)(2616005)(36756003)(186003)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IDgT47/kABFxu9k34U5zGEex45uxw7Hx4DfdKUI/HSUmK/RokFqg1VTSex?=
 =?iso-8859-1?Q?Akj+vsoywFVPdVjgNNsNIIVwuZKr05DLeCo5zVYR/pbwCFHCQEP6ULxNK4?=
 =?iso-8859-1?Q?WbbOTagnENCWN8DtVWO4jhrq1LJGE9qqn2pXpsJDqTGImd/7yo2f3B0C7X?=
 =?iso-8859-1?Q?qv6AfcA/+XbO5AT9greSbDTZdCOBS2HZiChv1EsYQsSSTwGyiOQnUFyDbb?=
 =?iso-8859-1?Q?zc7XNi8ZOg5h0T0+yLlVNXzVbnk/rk4XTHDNPFbXrbAcYmSRkp5bSAjQc+?=
 =?iso-8859-1?Q?mf9KbKMhxFmVUvhuDbrn4zvE7A+n0qI/Eh7Au7o28aGGF9Oi4ceOrbMOZt?=
 =?iso-8859-1?Q?FGcIA5U2WQdR9rnXTvevcCfrHVj7aqPoDKX4nEEsJHW0eEGaa0qry72uLJ?=
 =?iso-8859-1?Q?6yT6OrctyDdpflgvpSLQE88WjC3pgv7O/4pTOcwcSez9zN2PTwBmTZdtx+?=
 =?iso-8859-1?Q?wKTOGzlyxVKLot43ZnFlqLIu957Ixt2q88AT79/Scsz1dPG1LbP+DSDs9U?=
 =?iso-8859-1?Q?+qH2aeW7NfaqO/tRASmINMWEvcizpBRaum3uM0nndqTRThSf82IbpuetZk?=
 =?iso-8859-1?Q?9g9ehjaB5Fm3stQJ9hJOiZj/qYowgv9xS311r7BZOA0FinXKNm561URDyT?=
 =?iso-8859-1?Q?pWH3R7t6yLoVm20lxqcKsK721aQ0h4LQWI3CnQLbWmhPUBFPRSTnj87i7a?=
 =?iso-8859-1?Q?ImMM9TJR9Ncatczo4dacmKQYbGdcTiLMHENfXDlMm5zN1Eghb8d7genBbf?=
 =?iso-8859-1?Q?ylJBBkclJTCMmnSgv9L1Ya7477QCfuGQ2BFk5H8gFLgxZoPkLZsbZ7LXkh?=
 =?iso-8859-1?Q?yLVvUk2Ysxs58CXUQHKC+IulM2ehrpWd0LBh7x5N4KN2wkHWeLhFd45yiH?=
 =?iso-8859-1?Q?1LZ5TMolL0HQGetmQuDqkBWaF9MHHGjbPNKaLR9aqbhBG/4ojeS3z+uu0N?=
 =?iso-8859-1?Q?Lk/Lq0quImhV6fRoepNJvFgUCRikvKiZEeqZT1v9/iygTaUzi3PvTIle2v?=
 =?iso-8859-1?Q?e1Fu1bjUUxTtUAz8Foom8GMW4CXSHmUvVkhwAOH9QZEe93KVYTN3rYfWwz?=
 =?iso-8859-1?Q?G/HTXYNZMBPZUfzhZvBBPvxgqhWiSlWWguyB7whQlz046wyVey/fWR8CUu?=
 =?iso-8859-1?Q?WO6Hgo582YfjGh0dq7E1nVQemNh26rv8DEu4mLucR1T2lEv6RtDdGqTcmL?=
 =?iso-8859-1?Q?bOMgPfNUb7vKRiUvBPl4SanIqejhQWD385chpmRuXxEv07eWkz6DB0dGZC?=
 =?iso-8859-1?Q?hMJfor+LzdoWqXix7aOU8siyjmvCiIJyfEvhdLCC5FaPePczU6Figl+LNC?=
 =?iso-8859-1?Q?sIQRDwQblVQ0GBoq2DjUKtX+WhJ6ZsHXLD9S3R+evgSSpbEsTGy0mQtXmJ?=
 =?iso-8859-1?Q?6PckyxE9M3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef53407-218d-4426-d13a-08d96e7b1e61
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 01:35:31.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoItoO2Pn3Ragx5Ue02tc3UI4WL0iiOjp1kStQ3v5P+AlmePf2bZCqCUgQX/qzVwHimT5O6EgWQ7f4Mbp7oRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3258
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030007
X-Proofpoint-GUID: 60sE4Ohk3tTiBKHx5keAl_lwsmpLytb7
X-Proofpoint-ORIG-GUID: 60sE4Ohk3tTiBKHx5keAl_lwsmpLytb7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print to the trace log before releasing the lock to avoid racing with
other trace log printers of the same lock type.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/mmap_lock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 0540f0156f58..5d2b343e39e7 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -101,14 +101,14 @@ static inline bool mmap_write_trylock(struct mm_struc=
t *mm)
=20
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
-	up_write(&mm->mmap_lock);
 	__mmap_lock_trace_released(mm, true);
+	up_write(&mm->mmap_lock);
 }
=20
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
-	downgrade_write(&mm->mmap_lock);
 	__mmap_lock_trace_acquire_returned(mm, false, true);
+	downgrade_write(&mm->mmap_lock);
 }
=20
 static inline void mmap_read_lock(struct mm_struct *mm)
@@ -140,8 +140,8 @@ static inline bool mmap_read_trylock(struct mm_struct *=
mm)
=20
 static inline void mmap_read_unlock(struct mm_struct *mm)
 {
-	up_read(&mm->mmap_lock);
 	__mmap_lock_trace_released(mm, false);
+	up_read(&mm->mmap_lock);
 }
=20
 static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
--=20
2.30.2
