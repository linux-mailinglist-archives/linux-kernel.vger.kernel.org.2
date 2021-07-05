Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046523BB9B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGEJB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:01:59 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:35890 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhGEJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:01:58 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210705085920epoutp039d587aa498b23bbb895d7f5552f9f70c~O2WjlPDST1930019300epoutp038
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 08:59:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210705085920epoutp039d587aa498b23bbb895d7f5552f9f70c~O2WjlPDST1930019300epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625475560;
        bh=fctu0V/S79vb8UELNvNMxKR3h0pKZ3ff7qJEN3PAxZ4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aeq4W/uGTpT50B6BsFVUVkuzzeKKGULeyij1OF/WTQBJi7DtGupbnwj6kN3l+Q0mg
         BumDak2Sih4Ivqu8dGg5YsK9Zqg2iIEpUFi0yWM/7mW55xDrZBe62T6WHKW9lwLbQ7
         vBcljQX1BMWhUdRBJDwJfuhA+8GxtBBmGKY0EpKs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210705085919epcas1p118b04ea42c7de37c00f0dea6f6e8a549~O2WjDoeWf2231422314epcas1p1_;
        Mon,  5 Jul 2021 08:59:19 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GJKPL60wMz4x9QD; Mon,  5 Jul
        2021 08:59:18 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.0F.09551.6E9C2E06; Mon,  5 Jul 2021 17:59:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210705085918epcas1p1493a3b289b3144bf86e90893185c088a~O2Wh1JPK_1979719797epcas1p18;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705085918epsmtrp20ea08e684e0f9583735adbfe438039a5~O2Wh0YIEp1532215322epsmtrp2T;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
X-AuditID: b6c32a36-2b3ff7000000254f-d8-60e2c9e6eeeb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.45.08289.6E9C2E06; Mon,  5 Jul 2021 17:59:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705085917epsmtip28b3771bae4dad737725c410aa18a128c~O2WhnbRii2653026530epsmtip2j;
        Mon,  5 Jul 2021 08:59:17 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] mm: sparse: remove __section_nr() function
Date:   Mon,  5 Jul 2021 17:55:35 +0900
Message-Id: <20210705085538.14557-1-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmvu6zk48SDBZskrOYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjKeTrzKXLCJreLQlUmsDYx7WboYOTkkBEwk
        vhx/wd7FyMUhJLCDUWLJhW5WCOcTo8TTjrdsEM5nRolje58ww7SsOLgPqmUXo8SyQz9Z4Fom
        35rFBlLFJqAtsb/3BFiHiEC0xOyrHUwgNrNAgURD/yew5cICThIdT8+C1bAIqEpMWr8EzOYV
        sJHYNG8y1DZ5idUbDjCDLJAQOMcuceHLBajLXSQedN2AsoUlXh3fwg5hS0l8freXDaKhn1Hi
        UN92VghnAqPE+q5GoCoOIMde4v0lCxCTWUBTYv0ufYheRYmdv+cyQhzKJ/Huaw8rRDWvREeb
        EISpKrHstwdEtbRE3/TLbBC2h8SS3UfAbCGBWIlHZzqZJjDKzkKYv4CRcRWjWGpBcW56arFh
        gRFyLG1iBCc5LbMdjJPeftA7xMjEwXiIUYKDWUmEV2TKowQh3pTEyqrUovz4otKc1OJDjKbA
        8JrILCWanA9Ms3kl8YamRsbGxhYmZuZmpsZK4rw72Q4lCAmkJ5akZqemFqQWwfQxcXBKNTAp
        zf59KvzKbyG12Ij3G6e+fVWys/pZatJ78yN/7E0ENr/pMvi+a46LW47+xKq55/XkLs86+DQ0
        f3vvY/uzkx6KWglGupT4zvZQVeG/wxzDKVDZVsfJW+NweMvjlTEMN9riS2f+sHD5nKCxXe9h
        zRvN8jc8oit2rvB+XfWeS6LK1aYwXiuM6fG7f6dlJ7FNv72P+53RfEaNRRnM2T0Tcxtslh+s
        t/zUcH1z+T7fdffYJjB+OZATdPHaaU8+EVN1D/FonukKEitSTn+qLnvuUnau/8RCictnjjmY
        9B2RkS3vEHxefePk6dVeDEwVy/O7PJT1fOdLSq8Ks3z6IXbpWh6hh4pPGE9yzD9ve6KU7awS
        S3FGoqEWc1FxIgBnUxEi+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsWy7bCSvO6zk48SDB5NZreYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUVw2Kak5mWWpRfp2CVwZTydeZS7YxFZx6Mok
        1gbGvSxdjJwcEgImEisO7mPvYuTiEBLYwSjxYe0qdoiEtMTTF7uAijiAbGGJw4eLIWo+MErc
        7JjGClLDJqAtsb/3BDNIjYhAvMT8a2CtzAJlEldX/gUrERZwkuh4epYZxGYRUJWYtH4JmM0r
        YCOxad5kZohV8hKrNxxgnsDIs4CRYRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDA
        aWntYNyz6oPeIUYmDsZDjBIczEoivCJTHiUI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJe
        SCA9sSQ1OzW1ILUIJsvEwSnVwJSVUXnt7anPeyuzK4wvawT0p6cmTRFctPIufy2LLIOy5jFx
        DutZ7oyqPBqmyysDJ15QS5f+w7/Li31VbdcVniT1nTePbThqX/ZGMX5Cr2JK0DxG0Z9xuxc6
        3fXt+dCk7T1p1hnhWKe9mVcfXDihZmEf9sV4acWu0/NN+EUNwnWvdZ+4dC7Jfp3BqTW3o87N
        ud6awvZEU3Ff3rGo69L8TNE+Vywbhd4JvZ154bhtIvey5s6Kn69lwpOZXxYvrc58/PBa66/6
        qUu+f/fl+5lcs7+dfXprsmv2Qe+2VZ9+cbgVbJ4qNLnKIP3i449J5XlrnVrDc1ezNE8yCozf
        H3njxsFJUuvNd5t9Pj6zhd3sghJLcUaioRZzUXEiAEt4eYmnAgAA
X-CMS-MailID: 20210705085918epcas1p1493a3b289b3144bf86e90893185c088a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705085918epcas1p1493a3b289b3144bf86e90893185c088a
References: <CGME20210705085918epcas1p1493a3b289b3144bf86e90893185c088a@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains cleanups to remove __section_nr().

There were no code changes but only some modifications on commit
messages compared to the initial PATCH mailing list.

Also, I appended acked-by's and reviewed-by's from the initial mailing
list for convenience.

Ohhoon Kwon (3):
  mm: sparse: pass section_nr to section_mark_present
  mm: sparse: pass section_nr to find_memory_block
  mm: sparse: remove __section_nr() function

 .../platforms/pseries/hotplug-memory.c        |  4 +--
 drivers/base/memory.c                         |  4 +--
 include/linux/memory.h                        |  2 +-
 include/linux/mmzone.h                        |  1 -
 mm/sparse.c                                   | 35 +++----------------
 5 files changed, 9 insertions(+), 37 deletions(-)

-- 
2.17.1

