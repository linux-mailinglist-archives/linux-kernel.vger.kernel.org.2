Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFD73BC832
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGFJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:01:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34846 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhGFJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:01:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6536622339;
        Tue,  6 Jul 2021 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625561946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIoCohhBmLwX0tZuE6wi9Iniqd9FhFQjCo2EmfXrwqc=;
        b=JeWvoBhGX0Ytvvb0uonOWczCYPdXxtnG2grHGMv1KCnTjCYtI2ECTmQAaB03ad2OdqlpWS
        jbscky9mT6PiESASMTlR1BpNo+JJZK+nrNl4cSoxk1cIjCwx04bZ1CRC9vkeJmenC2EZ1G
        HnC5DrI2LdbcX/CY7h6mQTrB8trVk4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625561946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIoCohhBmLwX0tZuE6wi9Iniqd9FhFQjCo2EmfXrwqc=;
        b=oWWTEo2FvDicTxja6Hj7Sc4ZhH4X9ISOgwTM43KfLe5HMOmDkzeg5wDrxT7xy3CaA9DLJQ
        mXWB9TsViNUqekDw==
Received: from localhost (unknown [10.163.25.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 48A91A3B99;
        Tue,  6 Jul 2021 08:59:06 +0000 (UTC)
Date:   Tue, 6 Jul 2021 10:59:06 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <20210706085906.asz7cp7ydiid6yz5@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
 <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
 <YOQGRwLfLaFGqlVA@T590>
 <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
 <YOQYKn+POVR2g/h1@T590>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="e2hnbpubg4wjfkmm"
Content-Disposition: inline
In-Reply-To: <YOQYKn+POVR2g/h1@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e2hnbpubg4wjfkmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 06, 2021 at 04:45:30PM +0800, Ming Lei wrote:
> > /sys/kernel/debug/block/nvme0c0n1# find . -type f -exec grep -aH . {} \;
> 
> It is the mpath device's debugfs, what is output for the nvmef's
> debugfs?

Do you mean /sys/kernel/debug/block/{nvme0n1,nvme0n2}? These are
directories are empty.

There is only /sys/class/nvme/nvme0, but I don't think this is what you
are asking for.

--e2hnbpubg4wjfkmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="blk-debug2.txt"

/sys/class/nvme/nvme0# find . -type f -exec grep -aH . {} \;
grep: ./delete_controller: Permission denied
./uevent:MAJOR=245
./uevent:MINOR=0
./uevent:DEVNAME=nvme0
./uevent:NVME_TRTYPE=fc
./uevent:NVME_TRADDR=nn-0x201700a09890f5bf:pn-0x201b00a09890f5bf
./uevent:NVME_TRSVCID=none
./uevent:NVME_HOST_TRADDR=nn-0x200000109b579ef6:pn-0x100000109b579ef6
./cntlid:16065
./address:traddr=nn-0x201700a09890f5bf:pn-0x201b00a09890f5bf,host_traddr=nn-0x200000109b579ef6:pn-0x100000109b579ef6
./nvme0c0n1/uevent:DEVTYPE=disk
./nvme0c0n1/ext_range:0
./nvme0c0n1/ana_state:inaccessible
./nvme0c0n1/range:0
./nvme0c0n1/alignment_offset:0
./nvme0c0n1/power/runtime_active_time:0
./nvme0c0n1/power/runtime_active_kids:0
./nvme0c0n1/power/runtime_usage:0
./nvme0c0n1/power/runtime_status:unsupported
grep: ./nvme0c0n1/power/autosuspend_delay_ms: Input/output error
./nvme0c0n1/power/async:disabled
./nvme0c0n1/power/runtime_suspended_time:0
./nvme0c0n1/power/runtime_enabled:disabled
./nvme0c0n1/power/control:auto
./nvme0c0n1/ana_grpid:1
./nvme0c0n1/wwid:uuid.554bd55f-1de4-4600-a72a-e0e6da97b5be
./nvme0c0n1/ro:0
./nvme0c0n1/mq/0/cpu_list:0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 39
./nvme0c0n1/mq/0/nr_reserved_tags:1
./nvme0c0n1/mq/0/nr_tags:32
./nvme0c0n1/stat:       0        0        0        0        0        0        0        0        0        0        0        0        0        0        0      0
./nvme0c0n1/events_poll_msecs:-1
./nvme0c0n1/queue/io_poll_delay:-1
./nvme0c0n1/queue/max_integrity_segments:0
./nvme0c0n1/queue/zoned:none
./nvme0c0n1/queue/scheduler:[mq-deadline] kyber bfq none
./nvme0c0n1/queue/io_poll:0
./nvme0c0n1/queue/discard_zeroes_data:0
./nvme0c0n1/queue/minimum_io_size:4096
./nvme0c0n1/queue/nr_zones:0
./nvme0c0n1/queue/write_same_max_bytes:0
./nvme0c0n1/queue/max_segments:257
./nvme0c0n1/queue/dax:0
./nvme0c0n1/queue/physical_block_size:4096
./nvme0c0n1/queue/logical_block_size:4096
./nvme0c0n1/queue/virt_boundary_mask:4095
./nvme0c0n1/queue/zone_append_max_bytes:0
./nvme0c0n1/queue/io_timeout:30000
./nvme0c0n1/queue/nr_requests:64
./nvme0c0n1/queue/write_cache:write through
./nvme0c0n1/queue/stable_writes:0
./nvme0c0n1/queue/max_segment_size:4294967295
./nvme0c0n1/queue/rotational:0
./nvme0c0n1/queue/discard_max_bytes:0
./nvme0c0n1/queue/add_random:0
./nvme0c0n1/queue/discard_max_hw_bytes:0
./nvme0c0n1/queue/optimal_io_size:0
./nvme0c0n1/queue/chunk_sectors:0
./nvme0c0n1/queue/iosched/front_merges:1
./nvme0c0n1/queue/iosched/read_expire:500
./nvme0c0n1/queue/iosched/fifo_batch:16
./nvme0c0n1/queue/iosched/write_expire:5000
./nvme0c0n1/queue/iosched/writes_starved:2
./nvme0c0n1/queue/read_ahead_kb:128
./nvme0c0n1/queue/max_discard_segments:1
./nvme0c0n1/queue/write_zeroes_max_bytes:0
./nvme0c0n1/queue/nomerges:0
./nvme0c0n1/queue/zone_write_granularity:0
./nvme0c0n1/queue/wbt_lat_usec:2000
./nvme0c0n1/queue/fua:0
./nvme0c0n1/queue/discard_granularity:0
./nvme0c0n1/queue/rq_affinity:1
./nvme0c0n1/queue/max_sectors_kb:1024
./nvme0c0n1/queue/hw_sector_size:4096
./nvme0c0n1/queue/max_hw_sectors_kb:1024
./nvme0c0n1/queue/iostats:1
./nvme0c0n1/size:67108864
./nvme0c0n1/integrity/write_generate:0
./nvme0c0n1/integrity/format:none
./nvme0c0n1/integrity/read_verify:0
./nvme0c0n1/integrity/tag_size:0
./nvme0c0n1/integrity/protection_interval_bytes:0
./nvme0c0n1/integrity/device_is_integrity_capable:0
./nvme0c0n1/discard_alignment:0
./nvme0c0n1/uuid:554bd55f-1de4-4600-a72a-e0e6da97b5be
./nvme0c0n1/trace/end_lba:disabled
./nvme0c0n1/trace/act_mask:disabled
./nvme0c0n1/trace/start_lba:disabled
./nvme0c0n1/trace/enable:0
./nvme0c0n1/trace/pid:disabled
./nvme0c0n1/capability:630
./nvme0c0n1/hidden:1
./nvme0c0n1/removable:0
./nvme0c0n1/inflight:       0        0
./nvme0c0n1/nsid:1
./nvme0c0n1/make-it-fail:0
grep: ./reset_controller: Permission denied
./sqsize:31
./hostnqn:nqn.2014-08.org.nvmexpress:uuid:1a9e23dd-466e-45ca-9f43-a29aaf47cb21
./hostid:d5e55da0-19ae-42bc-a3ad-df9993cda3f6
./queue_count:2
./transport:fc
./subsysnqn:nqn.1992-08.com.netapp:sn.d646dc63336511e995cb00a0988fb732:subsystem.nvme-svm-dolin-ana_subsystem
./power/runtime_active_time:0
./power/runtime_active_kids:0
./power/runtime_usage:0
./power/runtime_status:unsupported
grep: ./power/autosuspend_delay_ms: Input/output error
./power/async:disabled
./power/runtime_suspended_time:0
./power/runtime_enabled:disabled
./power/control:auto
./reconnect_delay:2
grep: ./rescan_controller: Permission denied
./numa_node:-1
./model:NetApp ONTAP Controller
./dev:245:0
./fast_io_fail_tmo:off
./hwmon0/power/runtime_active_time:0
./hwmon0/power/runtime_active_kids:0
./hwmon0/power/runtime_usage:0
./hwmon0/power/runtime_status:unsupported
grep: ./hwmon0/power/autosuspend_delay_ms: Input/output error
./hwmon0/power/async:disabled
./hwmon0/power/runtime_suspended_time:0
./hwmon0/power/runtime_enabled:disabled
./hwmon0/power/control:auto
./hwmon0/temp1_label:Composite
./hwmon0/temp1_alarm:0
./hwmon0/temp1_input:-273150
./hwmon0/name:nvme
./firmware_rev:FFFFFFFF
./nvme0c0n2/uevent:DEVTYPE=disk
./nvme0c0n2/ext_range:0
./nvme0c0n2/ana_state:inaccessible
./nvme0c0n2/range:0
./nvme0c0n2/alignment_offset:0
./nvme0c0n2/power/runtime_active_time:0
./nvme0c0n2/power/runtime_active_kids:0
./nvme0c0n2/power/runtime_usage:0
./nvme0c0n2/power/runtime_status:unsupported
grep: ./nvme0c0n2/power/autosuspend_delay_ms: Input/output error
./nvme0c0n2/power/async:disabled
./nvme0c0n2/power/runtime_suspended_time:0
./nvme0c0n2/power/runtime_enabled:disabled
./nvme0c0n2/power/control:auto
./nvme0c0n2/ana_grpid:2
./nvme0c0n2/wwid:uuid.9d1866be-d687-40aa-bcff-90c7ce566435
./nvme0c0n2/ro:0
./nvme0c0n2/mq/0/cpu_list:0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 39
./nvme0c0n2/mq/0/nr_reserved_tags:1
./nvme0c0n2/mq/0/nr_tags:32
./nvme0c0n2/stat:       0        0        0        0        0        0        0        0        0        0        0        0        0        0        0      0
./nvme0c0n2/events_poll_msecs:-1
./nvme0c0n2/queue/io_poll_delay:-1
./nvme0c0n2/queue/max_integrity_segments:0
./nvme0c0n2/queue/zoned:none
./nvme0c0n2/queue/scheduler:[mq-deadline] kyber bfq none
./nvme0c0n2/queue/io_poll:0
./nvme0c0n2/queue/discard_zeroes_data:0
./nvme0c0n2/queue/minimum_io_size:4096
./nvme0c0n2/queue/nr_zones:0
./nvme0c0n2/queue/write_same_max_bytes:0
./nvme0c0n2/queue/max_segments:257
./nvme0c0n2/queue/dax:0
./nvme0c0n2/queue/physical_block_size:4096
./nvme0c0n2/queue/logical_block_size:4096
./nvme0c0n2/queue/virt_boundary_mask:4095
./nvme0c0n2/queue/zone_append_max_bytes:0
./nvme0c0n2/queue/io_timeout:30000
./nvme0c0n2/queue/nr_requests:64
./nvme0c0n2/queue/write_cache:write through
./nvme0c0n2/queue/stable_writes:0
./nvme0c0n2/queue/max_segment_size:4294967295
./nvme0c0n2/queue/rotational:0
./nvme0c0n2/queue/discard_max_bytes:0
./nvme0c0n2/queue/add_random:0
./nvme0c0n2/queue/discard_max_hw_bytes:0
./nvme0c0n2/queue/optimal_io_size:0
./nvme0c0n2/queue/chunk_sectors:0
./nvme0c0n2/queue/iosched/front_merges:1
./nvme0c0n2/queue/iosched/read_expire:500
./nvme0c0n2/queue/iosched/fifo_batch:16
./nvme0c0n2/queue/iosched/write_expire:5000
./nvme0c0n2/queue/iosched/writes_starved:2
./nvme0c0n2/queue/read_ahead_kb:128
./nvme0c0n2/queue/max_discard_segments:1
./nvme0c0n2/queue/write_zeroes_max_bytes:0
./nvme0c0n2/queue/nomerges:0
./nvme0c0n2/queue/zone_write_granularity:0
./nvme0c0n2/queue/wbt_lat_usec:2000
./nvme0c0n2/queue/fua:0
./nvme0c0n2/queue/discard_granularity:0
./nvme0c0n2/queue/rq_affinity:1
./nvme0c0n2/queue/max_sectors_kb:1024
./nvme0c0n2/queue/hw_sector_size:4096
./nvme0c0n2/queue/max_hw_sectors_kb:1024
./nvme0c0n2/queue/iostats:1
./nvme0c0n2/size:67108864
./nvme0c0n2/integrity/write_generate:0
./nvme0c0n2/integrity/format:none
./nvme0c0n2/integrity/read_verify:0
./nvme0c0n2/integrity/tag_size:0
./nvme0c0n2/integrity/protection_interval_bytes:0
./nvme0c0n2/integrity/device_is_integrity_capable:0
./nvme0c0n2/discard_alignment:0
./nvme0c0n2/uuid:9d1866be-d687-40aa-bcff-90c7ce566435
./nvme0c0n2/trace/end_lba:disabled
./nvme0c0n2/trace/act_mask:disabled
./nvme0c0n2/trace/start_lba:disabled
./nvme0c0n2/trace/enable:0
./nvme0c0n2/trace/pid:disabled
./nvme0c0n2/capability:630
./nvme0c0n2/hidden:1
./nvme0c0n2/removable:0
./nvme0c0n2/inflight:       0        0
./nvme0c0n2/nsid:2
./nvme0c0n2/make-it-fail:0
./state:connecting
./kato:5
./serial:80-AABMxwn3xAAAAAAAB
./ctrl_loss_tmo:600

--e2hnbpubg4wjfkmm--
