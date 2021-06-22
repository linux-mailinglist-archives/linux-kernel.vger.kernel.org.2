Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5329D3B0305
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFVLnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:43:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230330AbhFVLnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:43:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MBdqu2082037;
        Tue, 22 Jun 2021 07:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=w9YFt1TV0R+YHglCKyHGhELI4DE/9Y1DZN4tzptcFxw=;
 b=AlLSjN2w7jdiERff7QJvfYLJsX9fiTWWAfC+QX+MkG0aU7hp4WZ1dzvhyXh57J7XPDxt
 Uqypa0a1fXbDyWDCDh0xhJ2HOh72mqEWivvg8tzFnAoFGNXbVhoJL4X7Kv6PgVrQs/tD
 UVuqPcV2eXqjgnpTdsetj7wEra1+iKqlcPSEQeJhjGa9lg4LfC52gPwX/J5Jp7aO7CXD
 TlEKLzXGohUjWq5kDYtk4rNJKNusn4HNBD+uXd5CatXP6vyK0NTlOVSvbnkNuOx3vHKq
 Aw7BemvkFMO4jFbe2CTH+l0zmXG1dATNIhE/JbVgAZQ8aiuhRZ3Rk6TXFPFlYV0liD+M 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39bcm3513q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 07:40:59 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15MBe3k0082846;
        Tue, 22 Jun 2021 07:40:59 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39bcm35131-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 07:40:59 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15MBXvnD019176;
        Tue, 22 Jun 2021 11:40:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3997uh9dt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 11:40:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15MBes8531654366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 11:40:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4673A4055;
        Tue, 22 Jun 2021 11:40:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD5C7A404D;
        Tue, 22 Jun 2021 11:40:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.23.17])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jun 2021 11:40:53 +0000 (GMT)
Message-ID: <c8306569f880021bae853caf9f347e7c806ffaaa.camel@linux.ibm.com>
Subject: Re: [syzbot] possible deadlock in ovl_maybe_copy_up
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+c18f2f6a7b08c51e3025@syzkaller.appspotmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Tue, 22 Jun 2021 07:40:53 -0400
In-Reply-To: <CAOQ4uxjYJTG3p2ALXAWnAY+6Kmoi_L0=Z42okT6R+ovzQ7dQoQ@mail.gmail.com>
References: <000000000000c5b77105b4c3546e@google.com>
         <000000000000df47be05bf165394@google.com>
         <20210618040135.950-1-hdanton@sina.com>
         <23ba225593be391c384109af527bd0f3cb122a0d.camel@linux.ibm.com>
         <CAOQ4uxjYJTG3p2ALXAWnAY+6Kmoi_L0=Z42okT6R+ovzQ7dQoQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _tXHvbzhpUTDBZoW8qlSvgBxGotnSMQX
X-Proofpoint-GUID: Lbl2dTPsK2-W5IZZjoM6OWbM4cYjk_zE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_06:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Should annotating the iint be limited to files on overlay filesystems?
> >
> 
> Not to overlay files specifically but to files on stacked fs,
> i.e. (inode->i_sb->s_stack_depth > 0)
> Assuming that this patch is tested(?), how come it did not hit the
> WARN_ON_ONCE(depth < 0... above?

Thanks, Amir!

As per the overlayfs comment, the depth can never be 0.  It sounds like
in this case we only want to annotate the iint mutex for regular files,
if the stacking depth is greater than 0, but less than the max depth.

(I'm still trying to reproduce the lockdep.)

Mimi

