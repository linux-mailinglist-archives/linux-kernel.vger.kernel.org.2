Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95124412837
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 23:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbhITVnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 17:43:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:46277 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhITVlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 17:41:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="245650238"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="245650238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 14:37:32 -0700
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="511542810"
Received: from jkeelapa-mobl.amr.corp.intel.com (HELO [10.251.20.76]) ([10.251.20.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 14:37:31 -0700
Subject: Re: [PATCH 1/2] mm/migrate: optimize hotplug-time demotion order
 updates
To:     "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        mhocko@suse.com, weixugc@google.com, osalvador@suse.de,
        rientjes@google.com, dan.j.williams@intel.com, david@redhat.com,
        gthelen@google.com, yang.shi@linux.alibaba.com,
        akpm@linux-foundation.org
References: <20210917223504.C140445A@davehans-spike.ostc.intel.com>
 <20210917223505.F817CB6B@davehans-spike.ostc.intel.com>
 <87k0jeog7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <2d7e4078-f9c0-7511-0bab-de5dab25b45d@intel.com>
Date:   Mon, 20 Sep 2021 14:37:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0jeog7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/mixed;
 boundary="------------B43186B552DFF601C99F8E08"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B43186B552DFF601C99F8E08
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

On 9/17/21 5:55 PM, Huang, Ying wrote:
>> @@ -3147,6 +3177,16 @@ static void __set_migration_target_nodes
>>  	int node;
>>  
>>  	/*
>> +	 * The "migration path" array is heavily optimized
>> +	 * for reads.  This is the write side which incurs a
>> +	 * very heavy synchronize_rcu().  Avoid this overhead
>> +	 * when nothing of consequence has changed since the
>> +	 * last write.
>> +	 */
>> +	if (!node_demotion_topo_changed())
>> +		return;
>> +
>> +	/*
>>  	 * Avoid any oddities like cycles that could occur
>>  	 * from changes in the topology.  This will leave
>>  	 * a momentary gap when migration is disabled.
> Now synchronize_rcu() is called in disable_all_migrate_targets(), which
> is called for MEM_GOING_OFFLINE.  Can we remove the synchronize_rcu()
> from disable_all_migrate_targets() and call it in
> __set_migration_target_nodes() before we update the node_demotion[]?

I see what you are saying.  This patch just targeted
__set_migration_target_nodes() which is called in for
MEM_ONLINE/OFFLINE.  But, it missed MEM_GOING_OFFLINE's call to
disable_all_migrate_targets().

I think I found something better than what I had in this patch, or the
tweak you suggested: The 'memory_notify->status_change_nid' field is
passed to all memory hotplug notifiers and tells us whether the node is
going online/offline.  Instead of trying to track the changes, I think
we can simply rely on it to tell us when a node is going online/offline.

This removes the need for the demotion code to track *any* state.  I've
attached a totally untested patch to do this.

--------------B43186B552DFF601C99F8E08
Content-Type: text/x-patch; charset=UTF-8;
 name="faster-node-order.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="faster-node-order.patch"

diff -puN mm/migrate.c~faster-node-order mm/migrate.c
--- a/mm/migrate.c~faster-node-order	2021-09-17 14:44:58.697476940 -0700
+++ b/mm/migrate.c	2021-09-20 14:31:43.570477095 -0700
@@ -3239,8 +3239,18 @@ static int migration_offline_cpu(unsigne
  * set_migration_target_nodes().
  */
 static int __meminit migrate_on_reclaim_callback(struct notifier_block *=
self,
-						 unsigned long action, void *arg)
+						 unsigned long action, void *_arg)
 {
+	struct memory_notify *arg =3D _arg;
+
+	/*
+	 * Only update the node migration order when a node is
+	 * changing status, like online->offline.  This avoids
+	 * the overhead of synchronize_rcu() in most cases.
+	 */
+	if (arg->status_change_nid < 0)
+		return notifier_from_errno(0);
+
 	switch (action) {
 	case MEM_GOING_OFFLINE:
 		/*
_

--------------B43186B552DFF601C99F8E08--
