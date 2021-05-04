Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E60373280
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhEDWdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:33:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233461AbhEDWcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:32:11 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144M5KD9150438;
        Tue, 4 May 2021 18:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=X7EVs3vkSqYsqjf3PI8lzf7fThEuBAD5q5VbGWf7eM4=;
 b=mbf0n7RGEreK1ld2oa0c+Xj9WBbfK02pGMypjjPJ9Lh1Uat+TIa5NeXtHX4HOD8KsnK9
 0+PxMMEW0ambti7qdN+sDSg1xIcYnvgh+69Rpa8i7JiwaggNidq8pzoVR83lLmGfWa+5
 WPdb53zM9XCpO5NFvpGlKrDgZ+/TQFLEgfMyMU12JN/97CTY4VNskCv4TS8IfQb11N4G
 JzLceJeI+vYUa6r7oi6pNXvb8wyVXPg17DcmXMHX6VBt2ngVTpi0fUP+4XAc+LajGayH
 eDEJINSSH122Sv/KyhQFU10Zhxny+J0Gm/6dOEyQX4p5a8wc45hE4nnH3gZfC4or3mDk xg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38bea7h2wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 18:30:50 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144MRurg005510;
        Tue, 4 May 2021 22:30:50 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 38bedy899d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 22:30:49 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 144MUmhZ24969514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 22:30:48 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66B88136069;
        Tue,  4 May 2021 22:30:48 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46EB5136051;
        Tue,  4 May 2021 22:30:48 +0000 (GMT)
Received: from localhost (unknown [9.211.126.236])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  4 May 2021 22:30:48 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH v4] pseries/drmem: update LMBs after LPM
In-Reply-To: <20210504092038.8514-1-ldufour@linux.ibm.com>
References: <20210504092038.8514-1-ldufour@linux.ibm.com>
Date:   Tue, 04 May 2021 17:30:47 -0500
Message-ID: <87bl9qf7xk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RMKxhb73Agy0zbJ4y_iF5_HQfHVijSth
X-Proofpoint-ORIG-GUID: RMKxhb73Agy0zbJ4y_iF5_HQfHVijSth
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_15:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105040148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Bear with me while I work through the commit message:

Laurent Dufour <ldufour@linux.ibm.com> writes:
> After a LPM, the device tree node ibm,dynamic-reconfiguration-memory may be
> updated by the hypervisor in the case the NUMA topology of the LPAR's
> memory is updated.

Yes, the RTAS functions ibm,update-nodes and ibm,update-properties,
which the OS invokes after resuming, may bring in updated properties
under the ibm,dynamic-reconfiguration-memory node, including the
ibm,associativity-lookup-arrays property.

> This is caught by the kernel,

"Caught" makes me think this is an error condition, as in catching an
exception. I guess "handled" better conveys your meaning?

> but the memory's node is updated because
> there is no way to move a memory block between nodes.

"The memory's node" refers the ibm,dynamic-reconfiguration-memory DT
node, yes? Or is it referring to Linux's NUMA nodes? ("move a memory
block between nodes" in your statement here refers to Linux's NUMA
nodes, that much is clear to me.)

I am failing to follow the cause->effect relationship stated. True,
changing a block's node assignment while it's in use isn't safe. I don't
see why that implies that "the memory's node is updated"? In fact this
seems contradictory.

This statement makes more sense to me if I change it to "the memory's
node is _not_ updated" -- is this what you intended?

> If later a memory block is added or removed, drmem_update_dt() is called
> and it is overwriting the DT node to match the added or removed LMB.

I understand this, but I will expand on it.

dlpar_memory()
  -> dlpar_memory_add_by_count()
    -> dlpar_add_lmb()
      -> update_lmb_associativity_index()
        ... lmb->aa_index = <value>
  -> drmem_update_dt()

update_lmb_associativity_index() retrieves the firmware description of
the new block, and sets the aa_index of the matching entry in the
drmem_info array to the value matching the firmware description.

Then, drmem_update_dt() walks the drmem_info array and synthesizes a new
/ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory-v2 property based
on the recently updated information in that array.

> But the LMB's associativity node has not been updated after the DT
> node update and thus the node is overwritten by the Linux's topology
> instead of the hypervisor one.

So, an example of the problem is:

1. VM migrates. On resume, ibm,associativity-lookup-arrays is changed
   via ibm,update-properties. Entries in the drmem_info array remain
   unchanged, with aa_index values that correspond to the source
   system's ibm,associativity-lookup-arrays property, now inaccessible.

2. A memory block is added. We look up the new block's entry in the
   drmem_info array, and set the aa_index to the value matching the
   current ibm,associativity-lookup-arrays.

3. Then, the ibm,associativity-lookup-arrays property is completely
   regenerated from the drmem_info array, which reflects a mixture of
   information from the source and destination systems.

Do I understand correctly?


> Introduce a hook called when the ibm,dynamic-reconfiguration-memory node is
> updated to force an update of the LMB's associativity. However, ignore the
> call to that hook when the update has been triggered by drmem_update_dt().
> Because, in that case, the LMB tree has been used to set the DT property
> and thus it doesn't need to be updated back. Since drmem_update_dt() is
> called under the protection of the device_hotplug_lock and the hook is
> called in the same context, use a simple boolean variable to detect that
> call.

This strikes me as almost a revert of e978a3ccaa71 ("powerpc/pseries:
remove obsolete memory hotplug DT notifier code").

I'd rather avoid smuggling through global state information that ought
to be passed in function parameters, if it should be passed around at
all. Despite having (IMO) relatively simple responsibilities, this code
is difficult to change and review; adding this property makes it
worse. If the structure of the code is pushing us toward this kind of
compromise, then the code probably needs more fundamental changes.

I'm probably forgetting something -- can anyone remind me why we need an
array of these:

struct drmem_lmb {
	u64     base_addr;
	u32     drc_index;
	u32     aa_index;
	u32     flags;
};

which is just a less efficient representation of what's already in the
device tree? If we got rid of it, would this problem disappear?
