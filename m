Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A871337244
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhCKMSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:18:51 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:28276 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhCKMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:18:43 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210311121841epoutp04d49a2ac58c768f4a408646ea24aebe3f~rSPgG6GVo0619506195epoutp04Q
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:18:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210311121841epoutp04d49a2ac58c768f4a408646ea24aebe3f~rSPgG6GVo0619506195epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615465121;
        bh=ezUYeFnslrmzKbwJuJhAv6+KfoFwUjvpsw7SoBAt21Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BgTTN9odXW4ywzxkuOkYxnElvpEa/651OWwOU/um8UsQUT0xDI92uEbkOaKlyBA80
         5z51VmPei4Hq0dHAzw1cK8cIVoy3lK4HxT71tsDQGzguNk5P6AX7nknx8IZKS/18Iv
         WYBDXICAEVfK+HdCReqDkk4MDmLw90HQLC5gsQtQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210311121840epcas1p302b1ce7f837037d60384a21a31560cd4~rSPfRdfQK0692006920epcas1p3W;
        Thu, 11 Mar 2021 12:18:40 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Dx7Jv4hppz4x9Q0; Thu, 11 Mar
        2021 12:18:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.28.59147.F9A0A406; Thu, 11 Mar 2021 21:18:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210311121838epcas1p295d765b3c89ddacac9cd9bbf918d6345~rSPd0xb_21757017570epcas1p2i;
        Thu, 11 Mar 2021 12:18:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210311121838epsmtrp248085b90865a4f9819b6cbcede6a9970~rSPd0C94T0536705367epsmtrp2c;
        Thu, 11 Mar 2021 12:18:38 +0000 (GMT)
X-AuditID: b6c32a38-e3dff7000000e70b-49-604a0a9f4b53
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.92.08745.E9A0A406; Thu, 11 Mar 2021 21:18:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210311121838epsmtip16ef9075af635a905532e38e1e20b7620~rSPdkgv3Z1975719757epsmtip1Y;
        Thu, 11 Mar 2021 12:18:38 +0000 (GMT)
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
To:     snitzer@redhat.com
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        JeongHyeon Lee <jhs2.lee@samsung.com>
Subject: [PATCH 1/2] dm verity: fix DM_VERITY_OPTS_MAX value
Date:   Thu, 11 Mar 2021 21:10:50 +0900
Message-Id: <1615464651-23675-1-git-send-email-jhs2.lee@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7bCmnu58Lq8Egxn7FC3WnzrGbLH33WxW
        i0v377BaXN41h82ibeNXRgdWj/f7rrJ59G1ZxejxeZNcAHNUjk1GamJKapFCal5yfkpmXrqt
        kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1SakFKToGhQYFecWJucWleul5yfq6VoYGBkSlQZUJORsexT8wFbZwVC3dtY29gfMTe
        xcjBISFgIvHluWkXIxeHkMAORonTR0+zQzifGCXap0xlg3A+M0o8nHGfFaZjxgktiPguRomn
        jQugOr4wSkyZvZCxi5GTg01AW+J2yyZ2EFtEQEziSN8DVhCbWSBPYvGLdmYQW1jARmLVv6dg
        cRYBVYnnP96DxXkFXCRuz1jPBGJLCMhJ3DzXyQyyQEKgn13iy9SPrBAJF4l9lzvYIGxhiVfH
        t7BD2FISn9/tZYNo6GaUuH/+NVTRBEaJ3h4miBfsJd5fsgAxmQU0Jdbv0oeoUJTY+XsuI8Sd
        fBLvvvZAPcwr0dEmBFGiJLHi3zUWCFtCYsPhbqjhHhKrWw+BxYUEYiW+P53BOIFRdhbCggWM
        jKsYxVILinPTU4sNC0yQ42gTIzgVaVnsYJz79oPeIUYmDsZDjBIczEoivH7H3RKEeFMSK6tS
        i/Lji0pzUosPMZoCw2sis5Rocj4wGeaVxBuaGhkbG1uYmJmbmRorifMmGTyIFxJITyxJzU5N
        LUgtgulj4uCUamBaePaw+6kvfwvypWc9V3DXf5/1Xex1u7HeZltJ5eN2TQUdG5VDDDrjLk19
        tnpT50Jbk/h9Rp83MswofWVy2EZg7gv1aNknFtr3+uYnxB7dOGFT3q4vDTG2/zp5lQqn/Nt+
        cnt9pJ3T200m7ydFLNqUKW20e2nrdJ1JOX3P05vk2gK/1dzfZvBmsk+7tmLaKjGhFau+pWll
        +WytV7Wt7pC/4idW3LjCQ8r3dI1e/X3Lh3fPxB1hf/F6q7dRqtpDibsngsPOx8o3B/Cyn0kI
        bvH/dKlDSSi780qAVmpbCpvx9ZsGuwIkl2nqrkw3nHphmhe3nsek2XPkTaaaC6VG98e8irHY
        5+6UIdT2Ni7sphJLcUaioRZzUXEiAIUuoZfOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJMWRmVeSWpSXmKPExsWy7bCSnO48Lq8Eg8OnjC3WnzrGbLH33WxW
        i0v377BaXN41h82ibeNXRgdWj/f7rrJ59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV0bHsU/M
        BW2cFQt3bWNvYHzE3sXIwSEhYCIx44RWFyMXh5DADkaJhs9bmboYOYHiEhIbNq2FqhGWOHy4
        GKLmE6PE23dfWEFq2AS0JW63bGIHsUUExCSO9D0AizMLFEk837eADcQWFrCRWPXvKVicRUBV
        4vmP98wgNq+Ai8TtGeuhdslJ3DzXyTyBkWcBI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS9
        5PzcTYzg0NDS2sG4Z9UHvUOMTByMhxglOJiVRHj9jrslCPGmJFZWpRblxxeV5qQWH2KU5mBR
        Eue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cB02Vpi8xJflSMyswJ+byzZwzvrgzFvn4v1HM8t
        JavVb/55/vyntMFbZglu4w0PGsuqJK5W8vrvK2+I/5QWeP9S8pIpLVOL57VbfUou4tzztKhC
        fcvimdeLg7/fltv0s3bmqzyTvUInD7wKfXugpTJFdcWS32mRK+5fOrnbcvUvzW9+IYfmPEww
        LHBbt41F4d7fWoY596d1vF3+4vUqfn8egefPM0Pe/CpU2c77R7j+YoVBYR9HJJffXHYt4ReZ
        H+Zv/7r6Usiilfrqy34kruTdfDVix3Hl+8p8p37enVB9582r4JMpCv+rpbP3dwUdrvl1hvVD
        +naHCfsu8ClJF+qX2ZxSPe5lZfokb6bNnjiTjUosxRmJhlrMRcWJADkiDeB8AgAA
X-CMS-MailID: 20210311121838epcas1p295d765b3c89ddacac9cd9bbf918d6345
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210311121838epcas1p295d765b3c89ddacac9cd9bbf918d6345
References: <CGME20210311121838epcas1p295d765b3c89ddacac9cd9bbf918d6345@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three optional parameters at once using dm verity table is not
supported, option can only be used exclusively.

e.g.)
  (verity_mode) (ignore_zero_block) (check_at_most_once)

verity table: '1  /dev/sdb /dev/sdb 4096 4096 1028807 1028807
<hash_alg> <root_hash> <salt> 11 use_fec_from_device /dev/sdb
fec_roots 2 fec_blocks 1036909 fec_start 1036909
restart_on_corruption ignore_zero_blocks check_at_most_once'

Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>
---
 drivers/md/dm-verity-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 6b8e5bdd8526..808a98ef624c 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -34,7 +34,7 @@
 #define DM_VERITY_OPT_IGN_ZEROES	"ignore_zero_blocks"
 #define DM_VERITY_OPT_AT_MOST_ONCE	"check_at_most_once"
 
-#define DM_VERITY_OPTS_MAX		(2 + DM_VERITY_OPTS_FEC + \
+#define DM_VERITY_OPTS_MAX		(3 + DM_VERITY_OPTS_FEC + \
 					 DM_VERITY_ROOT_HASH_VERIFICATION_OPTS)
 
 static unsigned dm_verity_prefetch_cluster = DM_VERITY_DEFAULT_PREFETCH_SIZE;
-- 
2.17.1

