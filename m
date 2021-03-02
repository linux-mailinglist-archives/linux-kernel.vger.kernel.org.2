Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2E132A54D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350587AbhCBMWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383766AbhCBMFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:05:25 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531AC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 04:03:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l2so13712240pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 04:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIWiD5GiL0TDlarCC4Pp88TxrYDHIkIQwJWeubejCZw=;
        b=Z2ql1VtJpudQr/wL14jJCXO1cyb7mWjyuWQNwJvnKzhceewwjzURrioyUXO7M3hBsD
         Hz7xh6Iy482ZTb+WKZ2gPaOhfgbw+0Y5KBagZbPQjnBJVO2G/94WnqjigmMGMf5ZWC1w
         t4xf7QwpqDDDMmfwwQM6Js4EMzJ8N6aWgIABMGlaNR48YWl5tzYtiqc3K3HGq497kcCU
         horZ2U9vJPFxa4Np9toTapsckU2SMJeSYfWLdg4ehW9YmMIeSMp6nLYyE2Om64Jp6ns6
         K5VyKtj+OScVkp2ymnCFnLJWekAXAmH10xwosrbDw+7A+CJfg3jjwsZmUdln1knTuSg5
         Aa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIWiD5GiL0TDlarCC4Pp88TxrYDHIkIQwJWeubejCZw=;
        b=mOK+zruIiMsYAmxNVJXXDRvIfpQSQfDmsc0gpAsFPKhTMq6mZK49a5Y1Oh5irsUiJE
         wGGG3TOIl2DL5Dxox/sb/FNrf6dFZgWk3Bfeag2DzZluBynU2yvPSj3cMes7O2Pk7Asf
         DehcQSwmwD0dQKjr+5GHFXAclMzVgzxXSf6IIEdX5SzYf4jc+Id8pLfXt1rHO1W56zCF
         zThddRQIW5Th2iICOrrMrd1vEdvx8GwWhXN/Qc+h8LAIJKMALZ2q1Of9daw6Cs7Nbi02
         DB45OfjQBoG1GEJwoIsZaPmPEIPf265pFSm3et0LCJDv9nCTaudi6GdVqFvpV5xPt0gB
         XPuQ==
X-Gm-Message-State: AOAM530wNhD2XC3lHwSmKVYugoCv6j246r0fUHs0kqDPJdD/pv9mn84v
        F94YZHMZVB9Ok6iYV2mF5nq0TQ==
X-Google-Smtp-Source: ABdhPJxynBEJyyt2MHAxxYsdcMCQf+YI6anmXatlVk21dULcnDritPsKJcuWqgNsNqkWLKt1a1kyKA==
X-Received: by 2002:a63:e42:: with SMTP id 2mr17786056pgo.100.1614686612281;
        Tue, 02 Mar 2021 04:03:32 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([204.124.180.153])
        by smtp.gmail.com with ESMTPSA id jt21sm3080691pjb.51.2021.03.02.04.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 04:03:31 -0800 (PST)
Date:   Tue, 2 Mar 2021 20:03:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] perf cs-etm: Save aux records in each etm queue
Message-ID: <20210302120325.GB30731@leoy-ThinkPad-X240s>
References: <20210212144513.31765-1-james.clark@arm.com>
 <20210212144513.31765-4-james.clark@arm.com>
 <20210227071056.GA3317@leoy-ThinkPad-X240s>
 <a5fc9db1-d80b-5351-ad98-98c9599c6f11@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5fc9db1-d80b-5351-ad98-98c9599c6f11@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 05:43:43PM +0200, James Clark wrote:

[...]

> > I'd like to propose to add a new field "cs_etm_queue::buf_rec_len", it
> > stands for the record length based on the RECORD_AUX event.  In
> > theory, this value should be always less than "cs_etm_queue::buf_len".
> > 
> > When every time the "PERF_RECORD_AUX" event is coming, we find out the
> > corresponding queue (so this can be applied for "1:1" or "N:1" models
> > for source and sink), and accumulate "perf_record_aux::aux_size" into
> > "cs_etm_queue::buf_rec_len".
> > 
> > At the decoder side, it decreases "etmq->buf_rec_len" until to zero for
> > the current round of decoding (see cs_etm__decode_data_block()).  Since
> > all the "PERF_RECORD_AUX" event will be processed before
> > "PERF_RECORD_EXIT" event, so we don't worry the tail trace data will be
> > ignored.
> > 
> > The main reason for this suggestion is it don't need to change the
> > significant logic in current code.  I will try to do experiment for this
> > idea and share back.
> > 
> > James, if you think I miss anything, please correct me as needed.
> > Thanks!
> > 
> 
> This is an interesting idea, I think we could push decoded packets into the
> min heap as the aux records are received, and not do anything with them until
> the end of the data is reached. That way instead of saving aux records, we'd
> save the result of the decode for each aux record.
> 
> Currently each cs_etm_queue has a cs_etm_traceid_queue/cs_etm_packet_queue for each
> stream, but that would have to be changed to have multiple ones because multiple
> packets could be decoded to get through the whole aux record.
> 
> It would be a similarly sized change, and could also have a bigger impact on
> memory. So I'm not sure if it would help to reduce the changes, but it is possible.

Below change is still very coarse and I just did very basic testing for
it, so didn't cover all cases; so simply use it to demonstrate the basic
idea.

Before the event PERF_RECORD_AUX arrives, we don't decode any trace
data.  And after PERF_RECORD_AUX coming, the aux buffer size will be
accumulated into the queue, and decode the trace data for the queue
based on the accumulated buffer length.

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b9c1d329a7f1..3bd5609b6de4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -89,7 +89,7 @@ struct cs_etm_queue {
 	u8 pending_timestamp;
 	u64 offset;
 	const unsigned char *buf;
-	size_t buf_len, buf_used;
+	size_t aux_buf_len, buf_len, buf_used;
 	/* Conversion between traceID and index in traceid_queues array */
 	struct intlist *traceid_queues_list;
 	struct cs_etm_traceid_queue **traceid_queues;
@@ -1085,6 +1085,7 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 		if (old_buffer)
 			auxtrace_buffer__drop_data(old_buffer);
 		etmq->buf_len = 0;
+		etmq->aux_buf_len = 0;
 		return 0;
 	}
 
@@ -2052,6 +2053,7 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	etmq->offset += processed;
 	etmq->buf_used += processed;
 	etmq->buf_len -= processed;
+	etmq->aux_buf_len -= processed;
 
 out:
 	return ret;
@@ -2177,7 +2179,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 			 */
 			err = cs_etm__process_traceid_queue(etmq, tidq);
 
-		} while (etmq->buf_len);
+		} while (etmq->aux_buf_len > 0);
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
@@ -2216,6 +2218,27 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static void cs_etm__update_aux_buf_len(struct cs_etm_auxtrace *etm,
+				      struct perf_record_aux *aux)
+{
+	unsigned int cs_queue_nr, queue_nr;
+	struct auxtrace_queue *queue;
+	struct cs_etm_queue *etmq;
+
+	if (!etm->heap.heap_cnt)
+		return;
+
+	/* Take the entry at the top of the min heap */
+	cs_queue_nr = etm->heap.heap_array[0].queue_nr;
+	queue_nr = TO_QUEUE_NR(cs_queue_nr);
+	queue = &etm->queues.queue_array[queue_nr];
+	etmq = queue->priv;
+
+	etmq->aux_buf_len += aux->aux_size;
+	fprintf(stderr, "%s: aux_buf_len=%ld\n", __func__, etmq->aux_buf_len);
+	return;
+}
+
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 {
 	int ret = 0;
@@ -2272,6 +2295,9 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 		if (ret < 0)
 			goto out;
 
+		if (etmq->aux_buf_len <= 0)
+			goto out;
+
 		/*
 		 * No more auxtrace_buffers to process in this etmq, simply
 		 * move on to another entry in the auxtrace_heap.
@@ -2414,9 +2440,15 @@ static int cs_etm__process_event(struct perf_session *session,
 	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		return cs_etm__process_switch_cpu_wide(etm, event);
 
+	fprintf(stderr, "%s: event->header.type=%d\n", __func__, event->header.type);
+
 	if (!etm->timeless_decoding &&
-	    event->header.type == PERF_RECORD_AUX)
+	    event->header.type == PERF_RECORD_AUX) {
+
+		fprintf(stderr, "%s: aux_size=%lld\n", __func__, event->aux.aux_size);
+		cs_etm__update_aux_buf_len(etm, &event->aux);
 		return cs_etm__process_queues(etm);
+	}
 
 	return 0;
 }
