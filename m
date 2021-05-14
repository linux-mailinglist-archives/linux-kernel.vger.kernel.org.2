Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40703380615
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhENJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:23:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12772 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230514AbhENJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:23:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14E94bFM041767
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=oIUgmefJQ2iIoxhosFipkAPkZOj8uOobT9pEMb7la4s=;
 b=FuHcUyuLX43z7G56dwlVDFr3m2YMn2JfZOFz8B/A+rJOQTrvATUDBoBPNjWAud/whtjh
 uHjoQs3uSMEb8hOC+fYWp15O54SMl0buwbtZAFLea4J5LLaji+7tyvKX2/jGxbDe0FP/
 SWYcvwPTRHekLL5h9i9klygxpBh0HYbyot7aPqfowl0SYrF3rTrGY9e11Faebn1Dyesj
 wDTvoG7va9gdjgXxJdwL7dttdH58ZjR98DX+LoW64O+vEu8liVieHS2kaGqeYQX7sa5C
 2SBWP4s9QRA1qcrIcE6qy44IlP8ACP1NGsY9zpM5yutjkMfyFlq+Obs2hkodz79l8y2W jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hj2xwv51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:21:56 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14E95kUe045120
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:21:55 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hj2xwv4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 05:21:55 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14E9DR0o008577;
        Fri, 14 May 2021 09:21:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 38hc6rg3rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 09:21:53 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14E9LpJP30015844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 09:21:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B37394C050;
        Fri, 14 May 2021 09:21:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABE004C04E;
        Fri, 14 May 2021 09:21:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 May 2021 09:21:51 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 1018CE05BC; Fri, 14 May 2021 11:21:51 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC] minor kfence patches
Date:   Fri, 14 May 2021 11:21:37 +0200
Message-Id: <20210514092139.3225509-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zheoXeK5LncVIkYQShQBvYz7QFvjDpe7
X-Proofpoint-GUID: ud5Dk8OC5jHx5JyZITW4oWArDzmNbCdH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_04:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=849 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i'm currently looking into adding support for KFENCE to the s390
architecture. So far everything is straightforward, and i get the
kfence testsuite to pass, which is good! :)

One minor thing i encountered is that for a translation exception,
s390 only reports the page address, but not the complete address. I
worked around that by adding a function to kfence which allows to mask
out certain bits during unit testing. I wonder whether that should be a
weak function that can be implemented by architectures if required, some
kconfig option, or some other way?

The other thing is that s390 (and some other architectures) has different
address spaces for kernel and user space, so the decision whether an
address belongs to user or kernel space cannot be made by just looking
at the address. I added a small if (user_mode(regs)) check to
kfence_handle_page_fault(). But this could of also be done in the
architecture specific code.

What do you think?

Thanks,
Sven


