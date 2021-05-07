Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC9376D3F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhEGXXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 19:23:41 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44545 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhEGXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 19:23:37 -0400
Received: by mail-wr1-f53.google.com with SMTP id l13so10747295wru.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 16:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AeMAgGMTkDgLFETy4/5ZhdU7A3yaAgfsfiIqjLKnijw=;
        b=TNp/mukCwz4cBEwvg7gE5+KhZFsbrM3aW9/5szEz9TNHor8kodKzhYhS6P81ASwNY4
         Xf1n40Zrplb+44l4CmhuoCfGoiJzypDf6E/kaPG2AqSmYCAum24WTUyouUuLWBfPM5Uy
         +hXMseB3YaHx+IBscWSf5ENb63UTDwHmFJ5DMZLt4y4gVXbpfQUNJMepzQd65ifnphJd
         tEughT0BWIFX0uYlv5gzYXByotsrLiWlhH6tMMCE495trA/fXUe2F9A2NsQDQ+0GNUrX
         y3iutO8nTu/B6tGV5vy4TLWoTeZnhF8K2YSodHDu66iez7b9IyPTrptbNH9j7o3qlOJU
         fV9g==
X-Gm-Message-State: AOAM533pKyU9LDRdAC/sAeoqIe7HS6HOl2wR+m0ulEiOFAvaw18LODHb
        A2+H00xxGSCwP/wI/QAMz0U=
X-Google-Smtp-Source: ABdhPJy2p4vW4Ry9KxdXZerkIqNmXSbHpniiWGU+uZG0+Cs4IUGrqeWKmnZuBI6p8BPp1iPFggxxuQ==
X-Received: by 2002:adf:9bd0:: with SMTP id e16mr15534517wrc.346.1620429756228;
        Fri, 07 May 2021 16:22:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d07b:68ce:2d70:258f? ([2601:647:4802:9070:d07b:68ce:2d70:258f])
        by smtp.gmail.com with ESMTPSA id y17sm11296111wrw.90.2021.05.07.16.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 16:22:35 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To:     Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
 <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
Date:   Fri, 7 May 2021 16:22:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Well, that would require a modification to the CQE specification, no?
>>> fmds was not amused when I proposed that :-(
>>
>> Why would that require a modification to the CQE? it's just using say
>> 4 msbits of the command_id to a running sequence...
> 
> I think Hannes was under the impression that the counter proposal wasn't
> part of the "command_id". The host can encode whatever it wants in that
> value, and the controller just has to return the same value.

Yea, maybe something like this?
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6612971f4eb..7af48827ea56 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1006,7 +1006,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, 
struct request *req)
                 return BLK_STS_IOERR;
         }

-       cmd->common.command_id = req->tag;
+       cmd->common.command_id = nvme_cid(req);
         trace_nvme_setup_cmd(req, cmd);
         return ret;
  }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 05f31a2c64bb..96abfb0e2ddd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -158,6 +158,7 @@ enum nvme_quirks {
  struct nvme_request {
         struct nvme_command     *cmd;
         union nvme_result       result;
+       u8                      genctr;
         u8                      retries;
         u8                      flags;
         u16                     status;
@@ -497,6 +498,48 @@ struct nvme_ctrl_ops {
         int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
  };

+/*
+ * nvme command_id is constructed as such:
+ * | xxxx | xxxxxxxxxxxx |
+ *   gen    request tag
+ */
+#define nvme_cid_install_genctr(gen)           ((gen & 0xf) << 12)
+#define nvme_genctr_from_cid(cid)              ((cid & 0xf000) >> 12)
+#define nvme_tag_from_cid(cid)                 (cid & 0xfff)
+
+static inline u16 nvme_cid(struct request *rq)
+{
+       return nvme_cid_install_genctr(nvme_req(rq)->genctr++) | rq->tag;
+}
+
+static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
+               u16 command_id)
+{
+       u8 genctr = nvme_genctr_from_cid(command_id);
+       u16 tag = nvme_tag_from_cid(command_id);
+       struct request *rq;
+
+       rq = blk_mq_tag_to_rq(tags, tag);
+       if (unlikely(!rq)) {
+               pr_err("could not locate request for tag %#x\n",
+                       tag);
+               return NULL;
+       }
+       if (unlikely(nvme_req(rq)->genctr != genctr)) {
+               dev_err(nvme_req(rq)->ctrl->device,
+                       "request %#x genctr mismatch (got %#x expected 
%#x)\n",
+                       tag, nvme_req(rq)->genctr, genctr);
+               return NULL;
+       }
+       return rq;
+}
+
+static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
+                u16 command_id)
+{
+       return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
+}
+
  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
  void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
                             const char *dev_name);
@@ -594,7 +637,8 @@ static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)

  static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
  {
-       return !qid && command_id >= NVME_AQ_BLK_MQ_DEPTH;
+       return !qid &&
+               nvme_tag_from_cid(command_id) >= NVME_AQ_BLK_MQ_DEPTH;
  }

  void nvme_complete_rq(struct request *req);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..92e03f15c9f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1017,7 +1017,7 @@ static inline void nvme_handle_cqe(struct 
nvme_queue *nvmeq, u16 idx)
                 return;
         }

-       req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), command_id);
+       req = nvme_find_rq(nvme_queue_tagset(nvmeq), command_id);
         if (unlikely(!req)) {
                 dev_warn(nvmeq->dev->ctrl.device,
                         "invalid id %d completed on queue %d\n",
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 203b47a8ec92..ab5b7d175488 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1727,10 +1727,10 @@ static void nvme_rdma_process_nvme_rsp(struct 
nvme_rdma_queue *queue,
         struct request *rq;
         struct nvme_rdma_request *req;

-       rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
+       rq = nvme_find_rq(nvme_rdma_tagset(queue), cqe->command_id);
         if (!rq) {
                 dev_err(queue->ctrl->ctrl.device,
-                       "tag 0x%x on QP %#x not found\n",
+                       "got bad command_id %#x on QP %#x\n",
                         cqe->command_id, queue->qp->qp_num);
                 nvme_rdma_error_recovery(queue->ctrl);
                 return;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 919f6fe69cb3..c51b70aec6dd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -488,11 +488,11 @@ static int nvme_tcp_process_nvme_cqe(struct 
nvme_tcp_queue *queue,
  {
         struct request *rq;

-       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
+       rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
         if (!rq) {
                 dev_err(queue->ctrl->ctrl.device,
-                       "queue %d tag 0x%x not found\n",
-                       nvme_tcp_queue_id(queue), cqe->command_id);
+                       "got bad cqe.command_id %#x on queue %d\n",
+                       cqe->command_id, nvme_tcp_queue_id(queue));
                 nvme_tcp_error_recovery(&queue->ctrl->ctrl);
                 return -EINVAL;
         }
@@ -509,11 +509,11 @@ static int nvme_tcp_handle_c2h_data(struct 
nvme_tcp_queue *queue,
  {
         struct request *rq;

-       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
         if (!rq) {
                 dev_err(queue->ctrl->ctrl.device,
-                       "queue %d tag %#x not found\n",
-                       nvme_tcp_queue_id(queue), pdu->command_id);
+                       "got bad c2hdata.command_id %#x on queue %d\n",
+                       pdu->command_id, nvme_tcp_queue_id(queue));
                 return -ENOENT;
         }

@@ -600,7 +600,7 @@ static int nvme_tcp_setup_h2c_data_pdu(struct 
nvme_tcp_request *req,
         data->hdr.plen =
                 cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
         data->ttag = pdu->ttag;
-       data->command_id = rq->tag;
+       data->command_id = nvme_cid(rq);
         data->data_offset = cpu_to_le32(req->data_sent);
         data->data_length = cpu_to_le32(req->pdu_len);
         return 0;
@@ -613,11 +613,11 @@ static int nvme_tcp_handle_r2t(struct 
nvme_tcp_queue *queue,
         struct request *rq;
         int ret;

-       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
         if (!rq) {
                 dev_err(queue->ctrl->ctrl.device,
-                       "queue %d tag %#x not found\n",
-                       nvme_tcp_queue_id(queue), pdu->command_id);
+                       "got bad r2t.command_id %#x on queue %d\n",
+                       pdu->command_id, nvme_tcp_queue_id(queue));
                 return -ENOENT;
         }
         req = blk_mq_rq_to_pdu(rq);
@@ -699,7 +699,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
         struct nvme_tcp_request *req;
         struct request *rq;

-       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       rq = nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
         req = blk_mq_rq_to_pdu(rq);

         while (true) {
@@ -794,8 +794,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue 
*queue,
         }

         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-               struct request *rq = 
blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
-                                               pdu->command_id);
+               struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+                                       pdu->command_id);

                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
                 queue->nr_cqe++;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 1b89a6bb819a..9f1f5d572960 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -107,10 +107,10 @@ static void nvme_loop_queue_response(struct 
nvmet_req *req)
         } else {
                 struct request *rq;

-               rq = blk_mq_tag_to_rq(nvme_loop_tagset(queue), 
cqe->command_id);
+               rq = nvme_find_rq(nvme_loop_tagset(queue), cqe->command_id);
                 if (!rq) {
                         dev_err(queue->ctrl->ctrl.device,
-                               "tag 0x%x on queue %d not found\n",
+                               "got bad command_id %#x on queue %d\n",
                                 cqe->command_id, 
nvme_loop_queue_idx(queue));
                         return;
                 }
--
