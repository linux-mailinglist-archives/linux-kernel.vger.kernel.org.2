Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E82545E31C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 23:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbhKYXAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 18:00:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:33547 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344893AbhKYW6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 17:58:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="216285589"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="216285589"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 14:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="675370898"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2021 14:54:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqNdm-00072r-8T; Thu, 25 Nov 2021 22:54:54 +0000
Date:   Fri, 26 Nov 2021 06:54:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Wang <wei.w.wang@intel.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
        asias@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     kbuild-all@lists.01.org, Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Message-ID: <202111260614.IaGWVZYm-lkp@intel.com>
References: <20211125071554.16969-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125071554.16969-1-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on net-next/master net/master linus/master v5.16-rc2 next-20211125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Wei-Wang/virtio-vsock-fix-the-transport-to-work-with-VMADDR_CID_ANY/20211125-163238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20211126/202111260614.IaGWVZYm-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/007dbd2e6e604bf8b17a4cec1357113a26983838
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Wei-Wang/virtio-vsock-fix-the-transport-to-work-with-VMADDR_CID_ANY/20211125-163238
        git checkout 007dbd2e6e604bf8b17a4cec1357113a26983838
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/vmw_vsock/virtio_transport_common.c: In function 'virtio_transport_recv_pkt':
>> net/vmw_vsock/virtio_transport_common.c:1246:28: warning: variable 'vsk' set but not used [-Wunused-but-set-variable]
    1246 |         struct vsock_sock *vsk;
         |                            ^~~


vim +/vsk +1246 net/vmw_vsock/virtio_transport_common.c

e4b1ef152f53d5e Arseny Krasnov     2021-06-11  1238  
06a8fc78367d070 Asias He           2016-07-28  1239  /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
06a8fc78367d070 Asias He           2016-07-28  1240   * lock.
06a8fc78367d070 Asias He           2016-07-28  1241   */
4c7246dc45e2706 Stefano Garzarella 2019-11-14  1242  void virtio_transport_recv_pkt(struct virtio_transport *t,
4c7246dc45e2706 Stefano Garzarella 2019-11-14  1243  			       struct virtio_vsock_pkt *pkt)
06a8fc78367d070 Asias He           2016-07-28  1244  {
06a8fc78367d070 Asias He           2016-07-28  1245  	struct sockaddr_vm src, dst;
06a8fc78367d070 Asias He           2016-07-28 @1246  	struct vsock_sock *vsk;
06a8fc78367d070 Asias He           2016-07-28  1247  	struct sock *sk;
06a8fc78367d070 Asias He           2016-07-28  1248  	bool space_available;
06a8fc78367d070 Asias He           2016-07-28  1249  
f83f12d660d1171 Michael S. Tsirkin 2016-12-06  1250  	vsock_addr_init(&src, le64_to_cpu(pkt->hdr.src_cid),
06a8fc78367d070 Asias He           2016-07-28  1251  			le32_to_cpu(pkt->hdr.src_port));
f83f12d660d1171 Michael S. Tsirkin 2016-12-06  1252  	vsock_addr_init(&dst, le64_to_cpu(pkt->hdr.dst_cid),
06a8fc78367d070 Asias He           2016-07-28  1253  			le32_to_cpu(pkt->hdr.dst_port));
06a8fc78367d070 Asias He           2016-07-28  1254  
06a8fc78367d070 Asias He           2016-07-28  1255  	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
06a8fc78367d070 Asias He           2016-07-28  1256  					dst.svm_cid, dst.svm_port,
06a8fc78367d070 Asias He           2016-07-28  1257  					le32_to_cpu(pkt->hdr.len),
06a8fc78367d070 Asias He           2016-07-28  1258  					le16_to_cpu(pkt->hdr.type),
06a8fc78367d070 Asias He           2016-07-28  1259  					le16_to_cpu(pkt->hdr.op),
06a8fc78367d070 Asias He           2016-07-28  1260  					le32_to_cpu(pkt->hdr.flags),
06a8fc78367d070 Asias He           2016-07-28  1261  					le32_to_cpu(pkt->hdr.buf_alloc),
06a8fc78367d070 Asias He           2016-07-28  1262  					le32_to_cpu(pkt->hdr.fwd_cnt));
06a8fc78367d070 Asias He           2016-07-28  1263  
e4b1ef152f53d5e Arseny Krasnov     2021-06-11  1264  	if (!virtio_transport_valid_type(le16_to_cpu(pkt->hdr.type))) {
4c7246dc45e2706 Stefano Garzarella 2019-11-14  1265  		(void)virtio_transport_reset_no_sock(t, pkt);
06a8fc78367d070 Asias He           2016-07-28  1266  		goto free_pkt;
06a8fc78367d070 Asias He           2016-07-28  1267  	}
06a8fc78367d070 Asias He           2016-07-28  1268  
06a8fc78367d070 Asias He           2016-07-28  1269  	/* The socket must be in connected or bound table
06a8fc78367d070 Asias He           2016-07-28  1270  	 * otherwise send reset back
06a8fc78367d070 Asias He           2016-07-28  1271  	 */
06a8fc78367d070 Asias He           2016-07-28  1272  	sk = vsock_find_connected_socket(&src, &dst);
06a8fc78367d070 Asias He           2016-07-28  1273  	if (!sk) {
06a8fc78367d070 Asias He           2016-07-28  1274  		sk = vsock_find_bound_socket(&dst);
06a8fc78367d070 Asias He           2016-07-28  1275  		if (!sk) {
4c7246dc45e2706 Stefano Garzarella 2019-11-14  1276  			(void)virtio_transport_reset_no_sock(t, pkt);
06a8fc78367d070 Asias He           2016-07-28  1277  			goto free_pkt;
06a8fc78367d070 Asias He           2016-07-28  1278  		}
06a8fc78367d070 Asias He           2016-07-28  1279  	}
06a8fc78367d070 Asias He           2016-07-28  1280  
e4b1ef152f53d5e Arseny Krasnov     2021-06-11  1281  	if (virtio_transport_get_type(sk) != le16_to_cpu(pkt->hdr.type)) {
e4b1ef152f53d5e Arseny Krasnov     2021-06-11  1282  		(void)virtio_transport_reset_no_sock(t, pkt);
e4b1ef152f53d5e Arseny Krasnov     2021-06-11  1283  		sock_put(sk);
e4b1ef152f53d5e Arseny Krasnov     2021-06-11  1284  		goto free_pkt;
e4b1ef152f53d5e Arseny Krasnov     2021-06-11  1285  	}
e4b1ef152f53d5e Arseny Krasnov     2021-06-11  1286  
06a8fc78367d070 Asias He           2016-07-28  1287  	vsk = vsock_sk(sk);
06a8fc78367d070 Asias He           2016-07-28  1288  
06a8fc78367d070 Asias He           2016-07-28  1289  	lock_sock(sk);
06a8fc78367d070 Asias He           2016-07-28  1290  
3fe356d58efae54 Stefano Garzarella 2020-11-20  1291  	/* Check if sk has been closed before lock_sock */
3fe356d58efae54 Stefano Garzarella 2020-11-20  1292  	if (sock_flag(sk, SOCK_DONE)) {
8692cefc433f282 Jia He             2020-05-30  1293  		(void)virtio_transport_reset_no_sock(t, pkt);
8692cefc433f282 Jia He             2020-05-30  1294  		release_sock(sk);
8692cefc433f282 Jia He             2020-05-30  1295  		sock_put(sk);
8692cefc433f282 Jia He             2020-05-30  1296  		goto free_pkt;
8692cefc433f282 Jia He             2020-05-30  1297  	}
8692cefc433f282 Jia He             2020-05-30  1298  
ce7536bc7398e2a Stefano Garzarella 2021-02-08  1299  	space_available = virtio_transport_space_update(sk, pkt);
ce7536bc7398e2a Stefano Garzarella 2021-02-08  1300  
06a8fc78367d070 Asias He           2016-07-28  1301  	if (space_available)
06a8fc78367d070 Asias He           2016-07-28  1302  		sk->sk_write_space(sk);
06a8fc78367d070 Asias He           2016-07-28  1303  
06a8fc78367d070 Asias He           2016-07-28  1304  	switch (sk->sk_state) {
3b4477d2dcf2709 Stefan Hajnoczi    2017-10-05  1305  	case TCP_LISTEN:
c0cfa2d8a788fcf Stefano Garzarella 2019-11-14  1306  		virtio_transport_recv_listen(sk, pkt, t);
06a8fc78367d070 Asias He           2016-07-28  1307  		virtio_transport_free_pkt(pkt);
06a8fc78367d070 Asias He           2016-07-28  1308  		break;
3b4477d2dcf2709 Stefan Hajnoczi    2017-10-05  1309  	case TCP_SYN_SENT:
06a8fc78367d070 Asias He           2016-07-28  1310  		virtio_transport_recv_connecting(sk, pkt);
06a8fc78367d070 Asias He           2016-07-28  1311  		virtio_transport_free_pkt(pkt);
06a8fc78367d070 Asias He           2016-07-28  1312  		break;
3b4477d2dcf2709 Stefan Hajnoczi    2017-10-05  1313  	case TCP_ESTABLISHED:
06a8fc78367d070 Asias He           2016-07-28  1314  		virtio_transport_recv_connected(sk, pkt);
06a8fc78367d070 Asias He           2016-07-28  1315  		break;
3b4477d2dcf2709 Stefan Hajnoczi    2017-10-05  1316  	case TCP_CLOSING:
06a8fc78367d070 Asias He           2016-07-28  1317  		virtio_transport_recv_disconnecting(sk, pkt);
06a8fc78367d070 Asias He           2016-07-28  1318  		virtio_transport_free_pkt(pkt);
06a8fc78367d070 Asias He           2016-07-28  1319  		break;
06a8fc78367d070 Asias He           2016-07-28  1320  	default:
df12eb6d6cd920a Sebastien Boeuf    2020-02-14  1321  		(void)virtio_transport_reset_no_sock(t, pkt);
06a8fc78367d070 Asias He           2016-07-28  1322  		virtio_transport_free_pkt(pkt);
06a8fc78367d070 Asias He           2016-07-28  1323  		break;
06a8fc78367d070 Asias He           2016-07-28  1324  	}
c0cfa2d8a788fcf Stefano Garzarella 2019-11-14  1325  
06a8fc78367d070 Asias He           2016-07-28  1326  	release_sock(sk);
06a8fc78367d070 Asias He           2016-07-28  1327  
06a8fc78367d070 Asias He           2016-07-28  1328  	/* Release refcnt obtained when we fetched this socket out of the
06a8fc78367d070 Asias He           2016-07-28  1329  	 * bound or connected list.
06a8fc78367d070 Asias He           2016-07-28  1330  	 */
06a8fc78367d070 Asias He           2016-07-28  1331  	sock_put(sk);
06a8fc78367d070 Asias He           2016-07-28  1332  	return;
06a8fc78367d070 Asias He           2016-07-28  1333  
06a8fc78367d070 Asias He           2016-07-28  1334  free_pkt:
06a8fc78367d070 Asias He           2016-07-28  1335  	virtio_transport_free_pkt(pkt);
06a8fc78367d070 Asias He           2016-07-28  1336  }
06a8fc78367d070 Asias He           2016-07-28  1337  EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
06a8fc78367d070 Asias He           2016-07-28  1338  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
